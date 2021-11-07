
#err
Function unresolvedcallsfn(data struct,data inneroffset,data valuedata,data atend)
	data structure#1
	Data offset#1
	data addatend#1

	Data poff^offset
	Call getcontReg(struct,poff)
	add offset inneroffset

	Data err#1
	Data true=TRUE
	Data ptrobject%ptrobject

	If ptrobject#==true
		#Chars elf_rel_info_type={R_386_PC32}
		Chars elf_rel_info_type={R_386_32}
		Data ptrextra%ptrextra
		SetCall err addrel_base(offset,elf_rel_info_type,valuedata,atend,ptrextra)
	Else
		#add to resolve at end
		Data unressz=3*dwsz
		Data uncall%ptrunresolvedcalls
		data ptrstruct^structure

		set structure struct
		set addatend atend

		SetCall err addtosec(ptrstruct,unressz,uncall)
	EndElse
	Return err
EndFunction

#subtype is only when declarefn(not callfn)
#err
Function parsefunction(data ptrcontent,data ptrsize,data declare,sd subtype)
	Data true=TRUE
	Data false=FALSE

	Chars fnbegin="("
	Data zero=0
	Data fns%ptrfunctions
	Data code%ptrcodesec

	Data err#1
	Data noerr=noerror

	Str content#1
	Data size#1
	Data sz#1

	Set content ptrcontent#
	Set size ptrsize#
	
	SetCall sz valinmem(content,size,fnbegin)
	If sz==zero
		Chars funnameexp="Function name expected."
		Str fnerr^funnameexp
		Return fnerr
	EndIf
	If sz==size
		Chars startfnexp="Open parenthesis sign ('(') expected."
		Str starterr^startfnexp
		Return starterr
	EndIf

	sd b
	If declare==true
		Data fnnr=functionsnumber
		Data value#1
		Data ptrvalue^value

		data p_two_parse%cptr_twoparse
		if p_two_parse#==2
			Data globalinnerfunction%globalinnerfunction
			#set for searching in the main scope for unique value
			Data aux#1
			Set aux globalinnerfunction#
			Set globalinnerfunction# false
			SetCall err entryvarsfns(content,sz)
			If err!=noerr
				Return err
			EndIf
			Set globalinnerfunction# aux

			#is objfnmask related to the introduction of entry tag at objects, is interacting there
			Data mask#1
			Data ptrobjfnmask%ptrobjfnmask
			Set mask ptrobjfnmask#
			if subtype==(cFUNCTIONX)
				setcall b is_for_64()
				if b==(TRUE);or mask (x86_64bit);endif
			endif
			SetCall err addaref(value,ptrcontent,ptrsize,sz,fnnr,mask)
			If err!=noerr
				Return err
			EndIf
			#skip the rest of the command at recon
			Call advancecursors(ptrcontent,ptrsize,ptrsize#)
			return noerr
		else
			sd pointer
			setcall pointer vars_ignoreref(content,sz,fns)
			Call advancecursors(ptrcontent,ptrsize,sz)
			
			#add the function name to the code section if the option is set
			sd fn_text
			setcall fn_text fn_text_info()
			if fn_text#==1
				sd fn_name
				set fn_name pointer
				add fn_name (nameoffset)
				sd len
				setcall len strlen(fn_name)
				inc len
				SetCall err addtoCode_set_programentrypoint(fn_name,len)
				If err!=(noerror)
					Return err
				EndIf
			endif
			
			Call getcontReg(code,ptrvalue)
			set pointer# value

			#resolve the previous calls at this value
			Data ptrobject%ptrobject
			If ptrobject#==true
				Data STT_FUNC=STT_FUNC
				Data STB_GLOBAL=STB_GLOBAL
				Data codeind=codeind
				Data ptrtable%ptrtable
				SetCall err elfaddstrszsym(content,sz,value,zero,STT_FUNC,STB_GLOBAL,codeind,ptrtable)
				If err!=noerr
					Return err
				EndIf
			EndIf
			
			if subtype==(cFUNCTIONX)
				setcall b is_for_64()
				if b==(TRUE)
					setcall err function_start_64()
					If err!=noerr
						Return err
					EndIf
				endif
			endif
		endelse
	Else
		data boolindirect#1
		Data ptrdata#1
		setcall err prepare_function_call(ptrcontent,ptrsize,sz,#ptrdata,#boolindirect)
		if err!=(noerror)
			return err
		endif
		setcall err nr_of_args_64need_set();if err!=(noerror);return err;endif
	EndElse
	
	Call stepcursors(ptrcontent,ptrsize)
	data ptr_sz^sz
	setcall err parenthesis_size(ptrcontent#,ptrsize#,ptr_sz)
	if err!=noerr
		return err
	endif

	If sz!=zero
		#declare is bool
		SetCall err enumcommas(ptrcontent,ptrsize,sz,declare,fnnr,(not_used),(not_used))
		If err!=noerr
			Return err
		EndIf
	EndIf
	
	If declare==true
		call entryscope()
	else
		setcall err write_function_call(ptrdata,boolindirect,(FALSE))
		If err!=noerr
			Return err
		EndIf
	endelse
	Call stepcursors(ptrcontent,ptrsize)
	Return noerr
EndFunction
#p
function fn_text_info()
	data text_info#1
	return #text_info
endfunction

#err
function prepare_function_call(sd pcontent,sd psize,sd sz,sd p_data,sd p_bool_indirect)
	set p_bool_indirect# (FALSE)
	Data fns%ptrfunctions
	
	SetCall p_data# vars(pcontent#,sz,fns)
	If p_data#==0
		setcall p_data# vars_number(pcontent#,sz,(integersnumber))
		If p_data#==0
			setcall p_data# vars_number(pcontent#,sz,(stackdatanumber))
			If p_data#==0
				Chars unfndeferr="Undefined function/data name."
				Str ptrunfndef^unfndeferr
				Return ptrunfndef
			EndIf
		EndIf
		set p_bool_indirect# (TRUE)
	Else
		#at functions
		call is_for_64_is_impX_or_fnX_set(p_data#)
	EndElse
	Call advancecursors(pcontent,psize,sz)
	
	#move over the stack arguments
	#mov esp,ebx
		#callex(64) also use ebx to find the number of args
	Data code%ptrcodesec
	sd err
	#
	setcall err rex_w_if64();if err!=(noerror);return err;endif
	#
	chars espebx={moveatregthemodrm,0xe3}
	Str ptrespebx^espebx
	Data sizeespebx=2
	SetCall err addtosec(ptrespebx,sizeespebx,code)
	Return err
endfunction

#err
function write_function_call(sd ptrdata,sd boolindirect,sd is_callex)
	sd err
	Data code%ptrcodesec
	
	sd b;setcall b is_for_64_is_impX_or_fnX_get()
	if b==(TRUE)
		setcall err function_call_64(is_callex)
		If err!=(noerror);Return err;EndIf
	endif

	Data ptrfnmask#1
	Set ptrfnmask ptrdata
	Add ptrfnmask (maskoffset)
	
	Data fnmask#1
	Data idatafn=idatabitfunction
	Data ptrobject%ptrobject
	Set fnmask ptrfnmask#
	And fnmask idatafn
	
	If fnmask==idatafn
		If ptrobject#==(FALSE)
			Set boolindirect (TRUE)
		EndIf
	EndIf

	If boolindirect==(FALSE)
		Chars directcall#1
		Data directcalloff#1
		chars *={0xff,0xd0}
		
		Data ptrdirectcall^directcall
		const directcallsize=1+dwsz
		data ptrdirectcalloff^directcalloff

		If fnmask!=idatafn
			set directcall 0xe8
			setcall err unresolvedLocal(1,code,ptrdata,ptrdirectcalloff)
			If err!=(noerror);Return err;EndIf
			SetCall err addtosec(ptrdirectcall,(directcallsize),code)
			If err!=(noerror);Return err;EndIf
		Else
			#was: reloc when linking;0-dwsz(appears to be dwsz from Data directcallsize=1+dwsz), no truncation, so direct better
			set directcall 0xb8
			Set directcalloff 0
			SetCall err unresolvedcallsfn(code,1,ptrdata#,directcalloff)
			If err!=(noerror);Return err;EndIf
			SetCall err addtosec(ptrdirectcall,(directcallsize+2),code)
			If err!=(noerror);Return err;EndIf
		EndElse
	Else
		if fnmask==idatafn
			data ptrvirtualimportsoffset%ptrvirtualimportsoffset
			SetCall err unresolvedcallsfn(code,1,ptrdata#,ptrvirtualimportsoffset)
			If err!=(noerror);Return err;EndIf
		endif
		Chars callaction={0xff}
		Data noreg=noregnumber
		Chars callactionopcode={2}
		Data eaxregnumber=eaxregnumber
		call stack64_op_set()
		SetCall err writeoperation(ptrdata,callaction,noreg,(FALSE),callactionopcode,eaxregnumber)
		If err!=(noerror)
			Return err
		EndIf
	EndElse
	
	sd global_err_pB;setcall global_err_pB global_err_pBool()
	if global_err_pB#!=(FALSE)
		sd global_err_ptr;setcall global_err_ptr global_err_p()
		Data ptrextra%ptrextra
		#pointing to data. at 32 disp32 is absolute,at 64 relative
		If ptrobject#==(FALSE)
		#absolute
			const global_err_ex_start=!
			#mov ecx,imm32
			chars g_err_mov=0xb8+ecxregnumber;data g_err_mov_disp32#1
			#cmp byte[ecx],0
			chars *={0x80,7*toregopcode|ecxregnumber};chars *=0
			const global_err_ex_sz=!-global_err_ex_start
			#add rel,1 is (b8+ecx), one byte
			set g_err_mov_disp32 global_err_ptr#
			#
			SetCall err addtosec(#g_err_mov,(global_err_ex_sz),code)
		Else
			sd is64;setcall is64 is_for_64()
			if is64==(FALSE)
			#relative: using ecx(code absolute)+disp32
				const g_err_o32_b=!
				#mov ecx,coderel
				chars g_err_o32=0xb8+ecxregnumber;data g_err_rel#1
				#cmp byte[ecx+imm32],0
				chars *={0x80,7*toregopcode|ecxregnumber|0x80}
				#
				const g_err_o32_sz=!-g_err_o32_b
				#
				call getcontReg(code,#g_err_rel);add g_err_rel (bsz+dwsz+bsz+bsz+dwsz+bsz)
				SetCall err adddirectrel_base(ptrextra,(bsz),(codeind),g_err_rel);If err!=(noerror);Return err;EndIf
				SetCall err addtosec(#g_err_o32,(g_err_o32_sz),code);If err!=(noerror);Return err;EndIf
			else
			#relative
			#cmp byte[imm32],0
				chars g_err_cmp={0x80,7*toregopcode|5}
				#
				SetCall err addtosec(#g_err_cmp,(bsz+bsz),code);If err!=(noerror);Return err;EndIf
			endelse
				const global_err_obj_start=!
			data g_err_cmp_disp32#1
			chars *=0
				const global_err_obj_sz=!-global_err_obj_start
			set g_err_cmp_disp32 (0-global_err_obj_sz)
			sd ac_off;call getcontReg(code,#ac_off)
			SetCall err addrel_base(ac_off,(R_386_PC32),global_err_ptr#,g_err_cmp_disp32,ptrextra);If err!=(noerror);Return err;EndIf
			#
			SetCall err addtosec(#g_err_cmp_disp32,(global_err_obj_sz),code)
		EndElse
		If err!=(noerror);Return err;EndIf
		#jz
		chars g_err_jz=0x74;chars ret_end_sz#1
		#
		ss ret_end_p
		setcall ret_end_sz getreturn(#ret_end_p)
		sd is_linux_term;setcall is_linux_term is_linux_end()
		if is_linux_term==(TRUE)
			#int 0x80, sys_exit, eax 1,ebx the return number
			const g_err_sys_start=!
			chars g_err_sys={0x8b,ebxregnumber*toregopcode|0xc0|eaxregnumber}
			chars *={0xb8,1,0,0,0}
			Chars *={0xCD,0x80}
			const g_err_sys_size=!-g_err_sys_start
			set ret_end_sz (g_err_sys_size)
			set ret_end_p #g_err_sys
		endif
		SetCall err addtosec(#g_err_jz,(bsz+bsz),code);If err!=(noerror);Return err;EndIf
		#return
		SetCall err addtosec(ret_end_p,ret_end_sz,code);If err!=(noerror);Return err;EndIf
	endif
	
	return (noerror)
endfunction

#p
function global_err_p()
	data e#1
	return #e
endfunction
#p
function global_err_pBool()
	data bool#1
	return #bool
endfunction

#p
function entrylinux_bool_p()
	data entrylinux_bool#1;return #entrylinux_bool
endfunction
#bool
function is_linux_end()
	sd entrylinux_bool_ptr;setcall entrylinux_bool_ptr entrylinux_bool_p()
	return entrylinux_bool_ptr#
endfunction