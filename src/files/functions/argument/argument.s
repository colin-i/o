
#sz
function getreturn(data ptrptrcontinuation)
	sd b;setcall b scope64_get()
	if b==(TRUE)
		sd conv;setcall conv convdata((convdata_total))
		if conv==(lin_convention)
			char lin64_return={0xc9,0x5b}
			#pop c;add rsp,8*conv;push c
			char *={0x59,REX_Operand_64,0x83,regregmod|espregnumber,lin_convention*qwsz,0x51}
			char *=retcom
			set ptrptrcontinuation# #lin64_return
			return (2+6+1)
		endif
	endif
	Char returncontinuation={0xc9,0x5b,retcom}
	str ptrreturncontinuation^returncontinuation
	data sizeretcontinuation=3
	set ptrptrcontinuation# ptrreturncontinuation
	return sizeretcontinuation
endfunction
#err
function getexit(sv ptrptrcontinuation,sd psizeofcontinuation)
	#if to keep rsp can be leave pop sub rsp,:

	#int 0x80, sys_exit, eax 1,ebx the return number
	char sys_exit={0xb8,1,0,0,0}
	data exinit^sys_exit
	data exitsize=5
	Data codeptr%%ptr_codesec
	sd err
	SetCall err addtosec(exinit,exitsize,codeptr)
	If err!=(noerror)
		Return err
	EndIf

	Char unixcontinuation={intimm8,0x80}
	set ptrptrcontinuation# #unixcontinuation
	set psizeofcontinuation# 2
	return (noerror)
endfunction

#err
function argument_return(sd termswitch,ss pop,sd pregprepare_bool,sv pptrcontinuation,sd psizeofcontinuation,sd pregopcode)
	call setimm()
	Set pop# (moveatprocthemem)
	Set pregprepare_bool# (TRUE)

	if termswitch==(TRUE)
		data ebxregnumber=ebxregnumber
		set pregopcode# ebxregnumber
		sd err
		setcall err getexit(pptrcontinuation,psizeofcontinuation)
		return err
	endif
	set pregopcode# (eaxregnumber)
	setcall psizeofcontinuation# getreturn(pptrcontinuation)
	return (noerror)
endfunction

#err
Function argument(data ptrcontent,data ptrsize,data forwardORcallsens,data subtype)
	Data false=FALSE
	Data true=TRUE

	Data regprepare_bool#1

	Char op#1
	Data zero=0

	Str ptrcontinuation#1
	Data sizeofcontinuation#1

	vData codeptr%%ptr_codesec
	Data regopcode#1

	Data err#1
	Data forward=FORWARD

	Set regprepare_bool false
	Set sizeofcontinuation zero

	If forwardORcallsens==forward
		call unsetimm() #set is at returns/and at push

		sd xlog
		If subtype==(cRETURN)
			sd termswitch
			setcall termswitch is_linux_end() #exit from linux term
			setcall err argument_return(termswitch,#op,#regprepare_bool,#ptrcontinuation,#sizeofcontinuation,#regopcode)
			If err!=(noerror)
				Return err
			EndIf
			set xlog (Xfile_action_areturn)
		ElseIf subtype==(cINC)
			Char inc={0xFF}
			Set op inc
			set regopcode 0
			set xlog (Xfile_action_inc)
		ElseIf subtype==(cDEC)
			Char dec={0xFF}
			Char decregopcode={1}
			Set op dec
			Set regopcode decregopcode
			set xlog (Xfile_action_dec)
		ElseIf subtype<=(cDECST)
			set op (0x83)
			if subtype==(cINCST)
				set regopcode 0
				set xlog (Xfile_action_incst)
			else
				set regopcode 5
				set xlog (Xfile_action_decst)
			endelse
			char incs_sz#1
			sd b;setcall b is_for_64()
			if b==(FALSE);set incs_sz (dwsz)
			else;set incs_sz (qwsz);endelse
			set ptrcontinuation #incs_sz
			set sizeofcontinuation (bsz)
		ElseIf subtype==(cNEG)
			set op (0xf7)
			set regopcode 3
			set xlog (Xfile_action_neg)
		ElseIf subtype==(cNOT)
			Char not={0xF7}
			Char notregopcode={Notregopcode}
			Set op not
			Set regopcode notregopcode
			set xlog (Xfile_action_not)
		ElseIf subtype<=(cSAR)
			set op (0xD1)
			If subtype==(cSHL)
				set regopcode 4
				set xlog (Xfile_action_shl)
			ElseIf subtype==(cSHR)
				set regopcode 5
				set xlog (Xfile_action_shr)
			Else
			#cSAR
				set regopcode 7
				set xlog (Xfile_action_sar)
			EndElse
		Else
		#If subtype==(cEXIT)
			setcall err argument_return((TRUE),#op,#regprepare_bool,#ptrcontinuation,#sizeofcontinuation,#regopcode)
			If err!=(noerror)
				Return err
			EndIf
			set xlog (Xfile_action_aexit)
		EndElse
		setcall err xfile_add_char_if(xlog)
		If err!=(noerror);Return err;EndIf
	Else
	#push imm prepare test
		call setimm()
	EndElse

	Data lowbyte#1
	Data ptrlowbyte^lowbyte
	Data dataarg#1
	Data ptrdataarg^dataarg
	Data sufix#1
	Data ptrsufix^sufix

	SetCall err arg(ptrcontent,ptrsize,ptrdataarg,ptrlowbyte,ptrsufix,forwardORcallsens,(allow_yes))
	If err!=(noerror)
		Return err
	EndIf

	sd imm
	setcall imm getisimm()
	if imm==false
		#Data noreg=noregnumber
		#Data eaxreg=eaxregnumber
		#Data intchar#1
		#Set intchar noreg
		If forwardORcallsens!=forward
		#push
			#If lowbyte==false
			#since with 64 push data will push quad even without rex
			#	Char push={0xff}
			#	Char pushopcode={6}
			#	Set op push
			#	Set regopcode pushopcode
			#	call stack64_op_set()
			#Else
			#If lowbyte==true
			#	#prepare for eax for al
			#	Set intchar eaxreg
			#EndIf
			Char pushaction={moveatprocthemem}
			Set op pushaction
			set regopcode (eaxregnumber)

			char pushadvance={0x50}
			data pushcontinuationsize=1
			data ptrpushcontinuation^pushadvance
			Set ptrcontinuation ptrpushcontinuation
			set sizeofcontinuation pushcontinuationsize
			#EndElse
		ElseIf lowbyte==true
		#imm don't use one byte at the moment
			if regprepare_bool==false
				Dec op
			endif
		#Else;Set intchar regopcode
		EndElseIf
		sd comp_at_bigs;setcall comp_at_bigs comp_one(lowbyte,dataarg,sufix,op)
		setcall err writeop_promotes(dataarg,op,sufix,regopcode,lowbyte,comp_at_bigs)
		#call restore_argmask() #before this there is no err!=noerr: it is not a must, only less space
	Else
	#imm
		If forwardORcallsens!=forward
		#push
			setcall err write_imm(dataarg,(0x68))
		else
		#return/exit
			setcall err write_imm_sign(dataarg,regopcode)
		endelse
	EndElse
	If err!=(noerror)
		Return err
	EndIf
	If sizeofcontinuation!=zero
		#return / exit / (only at noimm):incst/push
		SetCall err addtosec(ptrcontinuation,sizeofcontinuation,codeptr)
		return err
	EndIf
	Return (noerror)
endfunction

#same as comp_sec
function comp_one(sd low,sd dataarg,sd sufix,sd op)
	if op==(moveatprocthemem)
		sd p
		if low==(FALSE)
			setcall p prefix_bool() #can't touch functions
			if p#==0
				sd big;setcall big is_big(dataarg,sufix)
				if big==(FALSE)
					sd for64;setcall for64 is_for_64()
					if for64==(TRUE)
						#is medium but with sign
						return 1
					endif
				endif
			endif
		else
			sd b;setcall b is_for_64()
			if b==(TRUE)
			#return all r64; take all; is from the time when was set that data, waiting outside, can have a char extended with zeros
				setcall p val64_p_get()
				set p# (val64_willbe)
			endif
			return 2
		endelse
	endif
	return -1
endfunction

#err
function argument_init(sv ptrcontent,sd ptrsize,sd subtype)
	sd err
	if subtype!=(cRETURN)
		if subtype!=(cEXIT)
			#exclude strings at inc,dec,...
			#can't go with allow_no because, for vars, will not exclude pass init
			setcall err getarg(ptrcontent,ptrsize,ptrsize#,(allow_later_sec),(FORWARD)) #there are 3 more arguments but are not used
			return err
		endif
	endif
	setcall err getarg(ptrcontent,ptrsize,ptrsize#,(allow_later),(FORWARD)) #there are 3 more arguments but are not used
	return err
endfunction
