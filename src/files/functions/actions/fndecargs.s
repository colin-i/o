

Function fndecargs(sv ptrcontent,sd ptrsize,sd sz,sd ptr_stackoffset,sd parses)
	If sz==0
		Chars szexp="Variable declaration expected."
		Str szexpptr^szexp
		Return szexpptr
	EndIf

	Data noerr=noerror
	Data pointerset%compointersvarsloc
	Data err#1
	Data perr^err
	data subtype#1

	Data ptrsearchsize^sz
	Data len#1
	Set len sz
	Set err noerr

	Call getcommand(ptrcontent,ptrsearchsize,#subtype,perr,pointerset)
	If err!=noerr
		Return err
	EndIf

	sd vartype
	setcall vartype commandSubtypeDeclare_to_typenumber(subtype)
	data is_stack#1
	data ptrstack^is_stack
	call stackfilter(vartype,ptrstack)

	#substract from the big size the parsed size
	Sub len sz
	Data length#1
	Set length ptrsize#
	Sub length len
	Set ptrsize# length

	sd datasize=dwsz
	sd long_mask=0
	sd b;setcall b is_for_64()
	if vartype>=(vnumbers)
		sub vartype (vnumbers)
		if vartype==(valuesinnernumber)
			set vartype (integersnumber)
			if b==(TRUE)
				set long_mask (valueslongmask)
				set datasize (qwsz)
			endif
		elseif b==(TRUE)
			set long_mask (datapointbit)
			set datasize (qwsz)
		endelseif
	elseif vartype==(charsnumber)
		set datasize (bsz)
	endelseif

	if parses==(pass_init)
		if is_stack==(FALSE)
			vdata ptrdataReg%ptrdataReg
			add ptrdataReg# datasize
		endif
		call advancecursors(ptrcontent,ptrsize,sz)
		return (noerror)
	endif

	#this is a write to sec for old data args, careful with stackoff
	Chars stacktransfer1#1;chars *={0x84,0x24}
	Data stackoff#1
	Chars stacktransfer2#1
	Data memoff#1

	sd stackindex
	setcall stackindex stack64_enlarge((dwsz))
	#(,sd *) is 5 at 64 is 8 but off_t on 32 ocompiler is signed(more at lseek), so no more than 32bits
	#setcall err maxsectioncheck(stackindex,ptr_stackoffset)

	add ptr_stackoffset# stackindex
	Set stackoff ptr_stackoffset#
	#stackoff is a write to sec for old data args

	setcall stackindex stack64_enlarge((stackinitpush))
	#setcall err maxsectioncheck(stackoff,#stackindex)
	add stackindex stackoff

	setcall err addvarreferenceorunref(ptrcontent,ptrsize,sz,vartype,stackindex,long_mask)
	If err!=noerr
		Return err
	EndIf

	if is_stack==(TRUE)
		return noerr
	endif

	Chars stackt1ini=moveatprocthemem
	Chars stackt2ini=0xA3

	Set stacktransfer1 stackt1ini
	Set stacktransfer2 stackt2ini

	setcall memoff get_img_vdata_dataReg()

	If datasize==(bsz)
		Dec stacktransfer1
		Dec stacktransfer2
	endIf

	Data null={NULL,NULL}
	Data ptrnull^null
	Data _datasec%ptrdatasec
	SetCall err addtosec(ptrnull,datasize,_datasec)
	If err!=noerr
		Return err
	EndIf

	if long_mask!=0
		call rex_w(#err)
		If err!=noerr;Return err;EndIf
	endif

	data p_is_object%ptrobject
	if p_is_object#==(TRUE)
		Const fndecargs_offend^memoff
		Const fndecargs_offstart^stacktransfer1
		Data ptrextra%ptrextra
		Data dataind=dataind
		sd reloff=fndecargs_offend-fndecargs_offstart
		if long_mask!=0
			inc reloff
		endif
		SetCall err adddirectrel_base(ptrextra,reloff,dataind,memoff)
		If err!=noerr
			Return err
		EndIf
		call inplace_reloc(#memoff)
	endif

	Data _codesec%ptrcodesec

	SetCall err addtosec(#stacktransfer1,(3*bsz+dwsz),_codesec);If err!=noerr;Return err;EndIf
	if long_mask!=0
		call rex_w(#err)
		If err!=noerr;Return err;EndIf
	endif
	SetCall err addtosec(#stacktransfer2,(bsz+dwsz),_codesec);If err!=noerr;Return err;EndIf

	if b==(TRUE)
		#at 64 code:
		#A3 XX.XX.XX.XX_XX.XX.XX.XX
		sd z=i386_obj_default_reloc_rah
		SetCall err addtosec(#z,(dwsz),_codesec)
		return err
	endif

	Return (noerror)
EndFunction
