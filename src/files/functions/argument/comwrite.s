
Function rol(data number,data times)
	Data nr#1
	Data i#1
	Data zero=0
	Data two=2

	Set nr number
	Set i zero
	While i<times
		Mult nr two
		Inc i
	EndWhile
	Return nr
EndFunction
#modrm
Function formmodrm(data mod,data regopcode,data rm)
	Data toregopcode=3
	Data tomod=3
	Data initialbitshift=1
	Data bitshift#1

	Data modrm#1
	Data store#1

	Set bitshift initialbitshift

	Set modrm rm
	
	SetCall bitshift rol(bitshift,toregopcode)
	Set store bitshift
	Mult store regopcode
	Or modrm store

	SetCall bitshift rol(bitshift,tomod)
	Set store bitshift
	Mult store mod
	Or modrm store

	Return modrm
EndFunction

function takewithimm(sd ind,sd addr)
	Chars takeop#1
	Data takeloc#1
	
	Set takeop (0xb8)
	Add takeop ind
	set takeloc addr
	
	Data ptrcodesec%ptrcodesec
	Data sz1=bsz+dwsz
	
	sd err
	SetCall err addtosec(#takeop,sz1,ptrcodesec)
	return err
endfunction
function writetake(sd takeindex,sd entry)
	data p_is_object%ptrobject
	Data ptrcodesec%ptrcodesec
	Data errnr#1
	
	sd take_loc;set take_loc entry#
	sd stack
	setcall stack stackbit(entry)
	if stack==0
		if p_is_object#==(TRUE)
			Data ptrextra%ptrextra
			data relocoff=1
			sd var
			setcall var function_in_code()
			if var#==0
				Data dataind=dataind
				SetCall errnr adddirectrel_base(ptrextra,relocoff,dataind,take_loc)
				If errnr!=(noerror)
					Return errnr
				EndIf
				set take_loc (i386_obj_default_reloc)
			else
				#function in code, not sd^local, sd^imp
				#function in code is only at objects at the moment, is set only once at arg.s
				#var# 0? is static bool
				set var# 0
				sd importbit
				setcall importbit get_importbit(entry)
				setcall take_loc get_function_value(importbit,entry)
				sd index
				setcall index get_function_values(importbit,#take_loc,entry)
				SetCall errnr adddirectrel_base(ptrextra,relocoff,index,take_loc)
				If errnr!=(noerror)
					Return errnr
				EndIf
				if importbit==0
					setcall errnr unresLc(1,ptrcodesec,0)
					If errnr!=(noerror)
						Return errnr
					EndIf
				endif
			endelse
		endif
		setcall errnr takewithimm(takeindex,take_loc)
	else
		chars stack_relative#1
		chars regreg=RegReg
		setcall stack_relative stack_get_relative(entry)
		chars getfromstack={0x03}
		chars getfromstack_modrm#1
		SetCall getfromstack_modrm formmodrm(regreg,takeindex,stack_relative)
		data ptrgetfromstack^getfromstack
		data sizegetfromstack=2
		if take_loc!=0
			setcall errnr takewithimm(takeindex,take_loc);If errnr!=(noerror);Return errnr;EndIf
			set getfromstack 0x03
		else;set getfromstack (moveatprocthemem);endelse
		setcall errnr rex_w_if64();if errnr!=(noerror);return errnr;endif
		SetCall errnr addtosec(ptrgetfromstack,sizegetfromstack,ptrcodesec)
	endelse
	Return errnr
endfunction

#er
Function writeoperation_take(sd location,sd sufix,sd takeindex,sd is_low)
#last parameter is optional
	Data ptrcodesec%ptrcodesec
	Data errnr#1
	Data noerr=noerror

	setcall errnr writetake(takeindex,location)
	If errnr!=noerr
		Return errnr
	EndIf


	sd take64stack=FALSE;sd v64
	sd stacktest;setcall stacktest stackbit(location)
	if stacktest!=0
		#p test
		sd for_64;setcall for_64 is_for_64()
		if for_64==(TRUE)
			set take64stack (TRUE)
			setcall v64 val64_p_get();set v64# (val64_willbe)
			#rex if p
		endif
		#take on takeindex
	endif
	Data true=TRUE
	If sufix==true
		if take64stack==(TRUE)
			call rex_w(#errnr);If errnr!=noerr;Return errnr;EndIf
			if is_low==(TRUE)
			#not ss, rex.w op r/m8 is ok but is useless
				set v64# (val64_no)
			else
				sd pbit;setcall pbit pointbit(location)
				if pbit==0
					#not needed at sd#
					sd prefix
					setcall prefix prefix_bool()
					if prefix#==0
					#but keep at prefix, this is a #a# case,the logic is fragile
						set v64# (val64_no)
					endif
				endif
			endelse
		endif
		Chars newtake=moveatprocthemem
		Chars newtakemodrm#1
		Str ptrnewtake^newtake
		Data sz2=bsz+bsz
		setcall newtakemodrm formmodrm((mod_0),takeindex,takeindex)
		SetCall errnr addtosec(ptrnewtake,sz2,ptrcodesec)
		Return errnr
	EndIf
	Return (noerror)
EndFunction
#er
Function writeoperation_op(sd operationopcode,sd regprepare,sd regopcode,sd takeindex)
	Data ptrcodesec%ptrcodesec
	Data errnr#1
	Data noerr=noerror
	Data sz2=bsz+bsz

	If regprepare!=(noregnumber)
		Chars comprepare1={0x33}
		Chars comprepare2#1
		setcall comprepare2 formmodrm((RegReg),regprepare,regprepare)
		SetCall errnr addtosec(#comprepare1,sz2,ptrcodesec)
		If errnr!=noerr
			Return errnr
		EndIf
	EndIf

	Chars actionop#1
	Chars actionmodrm#1
	
	Set actionop operationopcode
	
	sd prefix
	setcall prefix prefix_bool()
	sd mod=mod_0
	#prefix is tested here; the suffix is above
	if prefix#!=0
		set mod (RegReg)
		set prefix# 0
	endif
	Call stack64_op()
	#
	SetCall actionmodrm formmodrm(mod,regopcode,takeindex)
	sd v64;setcall v64 val64_p_get()
	if v64#==(val64_willbe)
		call rex_w(#errnr);if errnr!=(noerror);return errnr;endif
		set v64# (val64_no)
	endif
	SetCall errnr addtosec(#actionop,sz2,ptrcodesec)
	Return errnr
Endfunction
#er
Function writeoperation(sd location,sd operationopcode,sd regprepare,sd sufix,sd regopcode,sd takeindex,sd is_low)
	sd err
	setcall err writeoperation_take(location,sufix,takeindex,is_low)
	if err!=(noerror);return err;endif
	setcall err writeoperation_op(operationopcode,regprepare,regopcode,takeindex)
	return err
Endfunction

#er
Function writeop(sd location,sd operationopcode,sd regprepare,sd sufix,sd regopcode,sd is_low)
	Data err#1
	Data edxregnumber=edxregnumber
	SetCall err writeoperation(location,operationopcode,regprepare,sufix,regopcode,edxregnumber,is_low)
	Return err
EndFunction