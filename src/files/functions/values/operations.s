

Const unreadyNumber=0
Const addNumber=Xfile_numbers_operation_add
Const subNumber=Xfile_numbers_operation_sub
Const mulNumber=Xfile_numbers_operation_mul
Const divNumber=Xfile_numbers_operation_div
Const andNumber=Xfile_numbers_operation_and
Const orNumber=Xfile_numbers_operation_or
Const xorNumber=Xfile_numbers_operation_xor
Const powNumber=Xfile_numbers_operation_pow
Const remNumber=Xfile_numbers_operation_rem
Const lessNumber=Xfile_numbers_operation_less
Const greaterNumber=Xfile_numbers_operation_greater
Const shlNumber=Xfile_numbers_operation_shl
Const sarNumber=Xfile_numbers_operation_sar
Const shrNumber=Xfile_numbers_operation_shr
#asciiminus and asciinot for one arg

#err
function const_security()
	sd p%p_over_pref
	if p#=(TRUE)
		vstr err="Overflow at constants."
		call Message(err)
		sd w%p_w_as_e
		if w#=(TRUE)
			return err
		endif
	endif
	return (noerror)
endfunction
#err
function const_security_ex(sd p_once)
	if p_once#=0
		sd err;setcall err const_security()
		set p_once# 1
	endif
	return (noerror)
endfunction
#err
function shift_right(sd a,sd n)
	#at 64? 1 shl 63 is last one
	if n>31
		if a<0
			set a# -1
		else
			set a# 0   #here is clear that 30 is maximum but will be hardcoded
		endelse
	else
		while n>0
			sar1 a#
			dec n
		endwhile
	endelse
endfunction
#err
function shift_uright(sd a,sd n)
	if n>31
		set a# 0
	else
		while n>0
			shr1 a#
			dec n
		endwhile
	endelse
endfunction
#err
function shift_left(sd a,sd n)
	sd once=0
	while n>0
		sd how_was;set how_was a#
		shl1 a#
		if a#<^how_was
			sd err
			setcall err const_security_ex(#once)
			If err!=(noerror);return err;endif
		endif
		dec n
	endwhile
	return (noerror)
endfunction

#err pointer
Function operation(ss content,sd size,sd inoutvalue,sd number)
	sd newitem
	sd ptrnewitem^newitem
	sd errptr
	Data noerr=noerror

	if content#!=(asciiparenthesisstart)
		#not needing set newitem 0
		SetCall errptr numbersconstants(content,size,ptrnewitem)
	else
		inc content;sub size 2
		setcall errptr xfile_add_char_ifif((Xfile_numbers_parenthesis_open))
		if errptr=(noerror)
			setcall errptr parseoperations_base(#content,#size,size,ptrnewitem,(FALSE),(Xfile_numbers_parenthesis_close))
		endif
	endelse
	If errptr!=noerr;Return errptr;EndIf

	setcall errptr operation_core(inoutvalue,number,newitem)
	return errptr
EndFunction

#err
function operation_core(sd inoutvalue,sd number,sd newitem)
	sd errptr
	sd currentitem
	sd how_was
	sd how_is
	Set currentitem inoutvalue#
	If number=(addNumber)
		set how_was currentitem
		Add currentitem newitem
		if currentitem<^how_was
			setcall errptr const_security()
			if errptr!=(noerror);return errptr;endif
		endif
	ElseIf number=(subNumber)
		Sub currentitem newitem
	ElseIf number=(mulNumber)
		set how_was currentitem
		Mult currentitem newitem
		set how_is currentitem
		div how_is newitem
		if how_was!=how_is
			setcall errptr const_security()
			if errptr!=(noerror);return errptr;endif
		endif
	ElseIf number=(divNumber)
		Data zero=0
		If newitem=zero
			Char zerodiv="Division by 0 error."
			Str ptrzerodiv^zerodiv
			Return ptrzerodiv
		EndIf
		Div currentitem newitem
	ElseIf number=(andNumber)
		And currentitem newitem
	ElseIf number=(orNumber)
		Or currentitem newitem
	ElseIf number=(xorNumber)
		Xor currentitem newitem
	ElseIf number=(powNumber)
		if newitem<0
			if currentitem=0
				#is 1/(0 power n)
				Return ptrzerodiv
			elseif currentitem=1
				#is 1/(1 power n)
			else
				#is 1/(>1)
				set currentitem 0
			endelse
		elseif newitem=0
			set currentitem 1
		else
			sd once=0
			sd item;set item currentitem
			while newitem!=1
				set how_was currentitem
				mult currentitem item
				set how_is currentitem
				div how_is item
				if how_was!=how_is
					SetCall errptr const_security_ex(#once)
					If errptr!=(noerror);return errptr;endif
				endif
				dec newitem
			endwhile
		endelse
	ElseIf number=(remNumber)
		If newitem=zero
			Return ptrzerodiv
		EndIf
		Rem currentitem newitem
	ElseIf number=(shlNumber)
		SetCall errptr shift_left(#currentitem,newitem)
		If errptr!=(noerror);return errptr;endif
	ElseIf number=(sarNumber)
		Call shift_right(#currentitem,newitem)
	elseIf number=(shrNumber)
		Call shift_uright(#currentitem,newitem)
	ElseIf number=(lessNumber)
		if currentitem<newitem
			set currentitem (TRUE)
		else
			set currentitem (FALSE)
		endelse
	Else
	#If number=(greaterNumber)
		if currentitem>newitem
			set currentitem (TRUE)
		else
			set currentitem (FALSE)
		endelse
	EndElse

	Set inoutvalue# currentitem
	Return (noerror)
endfunction

#bool
Function signop(char byte,sv outval)
	Data false=FALSE
	Data true=TRUE

	If byte=(addNumber)
	ElseIf byte=(subNumber)
	ElseIf byte=(mulNumber)
	ElseIf byte=(divNumber)
	ElseIf byte=(andNumber)
	ElseIf byte=(orNumber)
	ElseIf byte=(xorNumber)
	ElseIf byte=(powNumber)
	ElseIf byte=(remNumber)
	ElseIf byte=(lessNumber)
	ElseIf byte=(greaterNumber)
	Else
		return false
	EndElse
	set outval# byte
	Return true
EndFunction

#err
Function oneoperation(sd ptrcontent,ss initial,ss content,sd val,sd op)
	sd errptr

	if op=(unreadyNumber)
		set op (addNumber)
	else
		setcall errptr xfile_add_char_ifif(op)
		if errptr!=(noerror);Return errptr;endif
	endelse

	sd size

	Set size content
	Sub size initial

	SetCall errptr operation(initial,size,val,op)
	If errptr!=(noerror)
		Set ptrcontent# initial
		Return errptr
	EndIf
	Return (noerror)
EndFunction

#err
function operation_test(sv ptrcontent,sd initial,sv ptrcursor,sd end,sd ptrval,sd pnumber,sd pnr,sd pbool)
	ss content;set content ptrcursor#
	if initial!=content ##to ignore -n
		ss test;set test content;dec test
		if test#=(not_number) #to ignore ~-n
			if initial=test ##if not this, a~-b will anyway stop at a~, but this test is logic
				return (noerror)
			endif
		endif
		sd err
		SetCall err oneoperation(ptrcontent,initial,content,ptrval,pnumber#)
		If err=(noerror)
			call multisignoperation(pnr,ptrcursor,end)
			set pnumber# pnr#
			Set pbool# (TRUE)
		endif
		return err
	endif
	return (noerror)
endfunction

#err pointer
Function parseoperations(sd ptrcontent,sd ptrsize,sd sz,sd outvalue,sd comments)
	sd er;setcall er parseoperations_base(ptrcontent,ptrsize,sz,outvalue,comments,(Xfile_numbers_done))
	return er
EndFunction
#err pointer
Function parseoperations_base(sd ptrcontent,sd ptrsize,sd sz,sd outvalue,sd comments,sd xfile_numbers)
	ss content
	ss initial
	sd number
	sd val
	sd ptrval^val
	Data zero=0
	sd errptr
	Data noerr=noerror

	Set content ptrcontent#

	Set initial content
	Set number (unreadyNumber)
	Set val zero

	sd bool
	Data false=FALSE
	Data true=TRUE
	sd nr
	sd pnr^nr
	sd find

	sd end;set end content;add end sz

	Set bool false
	#<end?maybe unsigned cursor
	While content!=end
		SetCall find signop(content#,pnr)
		if find=true
			setcall errptr operation_test(ptrcontent,initial,#content,end,ptrval,#number,pnr,#bool)
			if errptr!=noerr
				return errptr
			endif
		elseif content#=(asciiparenthesisstart)
			inc content
			sd rest_sz;set rest_sz end;sub rest_sz content
			sd insz
			setcall errptr parenthesis_size(content,rest_sz,#insz)
			if errptr!=(noerror);return errptr;endif
			add content insz
		endelseif

		Inc content
		If bool=true
			setcall content mem_spaces(content,end)
			Set initial content
			Set bool false
		EndIf
	EndWhile

	#allow line end comment
	if comments=(TRUE)
		sd szz
		set szz end;sub szz initial
		sd size
		setcall size find_whitespaceORcomment(initial,szz)
		sub szz size
		sub content szz
	endif
	#oneoperation is with cursor adjuster for errors
	SetCall errptr oneoperation(ptrcontent,initial,content,ptrval,number)
	If errptr!=noerr
		Return errptr
	EndIf
	Set outvalue# val

	if comments=(TRUE)
		sub sz szz
	endif
	Call advancecursors(ptrcontent,ptrsize,sz)

	setcall errptr xfile_add_char_ifif(xfile_numbers)
	Return errptr
EndFunction

function multisignoperation(ss pnr,sv pcontent,sd end)
	sd nr;set nr pnr#
	ss content
	if nr!=(lessNumber)
		if nr!=(greaterNumber)
			ret
		else
			set content pcontent#
			inc content
			if content!=end ##error is catched how was before
				if content#=(greaterNumber)
					set pnr# (sarNumber)
					set pcontent# content
					inc content
					if content!=end ##error is catched how was before
						if content#=(greaterNumber)
							set pnr# (shrNumber)
							set pcontent# content
						endif
					endif
				endif
			endif
		endelse
	else
		set content pcontent#
		inc content
		if content!=end ##error is catched how was before
			if content#=(lessNumber)
				set pnr# (shlNumber)
				set pcontent# content
			endif
		endif
	endelse
endfunction
