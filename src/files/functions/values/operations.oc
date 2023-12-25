

Const unreadyNumber=0
Const addNumber=Xfile_numbers_operation_add
Const subNumber=Xfile_numbers_operation_sub
Const mulNumber=Xfile_numbers_operation_mul
Const divNumber=Xfile_numbers_operation_div
Const divuNumber=Xfile_numbers_operation_divu
Const andNumber=Xfile_numbers_operation_and
Const orNumber=Xfile_numbers_operation_or
Const xorNumber=Xfile_numbers_operation_xor
Const powNumber=Xfile_numbers_operation_pow
Const remNumber=Xfile_numbers_operation_rem
Const remuNumber=Xfile_numbers_operation_remu
Const shlNumber=Xfile_numbers_operation_shl
Const sarNumber=Xfile_numbers_operation_sar
Const shrNumber=Xfile_numbers_operation_shr
Const equalNumber=Xfile_numbers_operation_equal
Const inequalNumber=Xfile_numbers_operation_inequal
Const lessNumber=Xfile_numbers_operation_less
Const greaterNumber=Xfile_numbers_operation_greater
Const lessequalNumber=Xfile_numbers_operation_lessequal
Const greaterequalNumber=Xfile_numbers_operation_greaterequal
Const andlogicalNumber=Xfile_numbers_operation_logicaland
Const orlogicalNumber=Xfile_numbers_operation_logicalor
Const unsignedlessNumber=Xfile_numbers_operation_unsignedless
Const unsignedgreaterNumber=Xfile_numbers_operation_unsignedgreater
Const unsignedlessequalNumber=Xfile_numbers_operation_unsignedlessequal
Const unsignedgreaterequalNumber=Xfile_numbers_operation_unsignedgreaterequal
Const parityNumber=Xfile_numbers_operation_parity
Const oddNumber=Xfile_numbers_operation_odd
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
	if n>^31
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
	if n>^31
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
	if a#!=0 #a can be 0 and how_was can't catch there
		sd once=0
		while n>^0
			sd how_was;set how_was a#
			shl1 a#
			if a#<^how_was
				sd err
				setcall err const_security_ex(#once)
				If err!=(noerror);return err;endif
			endif
			dec n
		endwhile
	endif
	return (noerror)
endfunction

#err pointer
Function operation(sv ptrcontent,sd size,sd inoutvalue,sd number)
	ss content
	set content ptrcontent#
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
	If errptr!=noerr
		set ptrcontent# content
		Return errptr
	EndIf

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
		divu how_is newitem
		if how_was!=how_is
			setcall errptr const_security()
			if errptr!=(noerror);return errptr;endif
		endif
	ElseIf number=(divNumber)
		If newitem=0
			Char zerodiv="Division by 0 error."
			vStr ptrzerodiv^zerodiv
			Return ptrzerodiv
		EndIf
		Div currentitem newitem
	ElseIf number=(divuNumber)
		If newitem=0
			Return ptrzerodiv
		EndIf
		Divu currentitem newitem
	ElseIf number=(andNumber)
		And currentitem newitem
	ElseIf number=(orNumber)
		Or currentitem newitem
	ElseIf number=(xorNumber)
		Xor currentitem newitem
	ElseIf number=(powNumber)
	#unsigned newitem/currentitem is the first step i think
		if currentitem=1
			#1/(1 power n) and positive, currentitem unchanged
		elseif currentitem=0
			if newitem=0
				return "0 pow 0 is undefined."
			endif
			#if newitem<0 #	#is 1/(0 power n) #	Return ptrzerodiv #endif #currentitem unchanged
		#elseif newitem<0 #	#is 1/(>1) #	set currentitem 0
		elseif newitem=0
			set currentitem 1
		#elseif newitem=1 #currentitem unchanged
		else
			sd once=0
			sd item;set item currentitem
			while newitem!=1
				set how_was currentitem
				mult currentitem item
				set how_is currentitem
				divu how_is item
				if how_was!=how_is
					SetCall errptr const_security_ex(#once)
					If errptr!=(noerror);return errptr;endif
				endif
				dec newitem
			endwhile
		endelse
	ElseIf number=(remNumber)
		If newitem=0
			Return ptrzerodiv
		EndIf
		Rem currentitem newitem
	ElseIf number=(remuNumber)
		If newitem=0
			Return ptrzerodiv
		EndIf
		Remu currentitem newitem
	ElseIf number=(shlNumber)
		SetCall errptr shift_left(#currentitem,newitem)
		If errptr!=(noerror);return errptr;endif
	ElseIf number=(sarNumber)
		Call shift_right(#currentitem,newitem)
	elseIf number=(shrNumber)
		Call shift_uright(#currentitem,newitem)
	ElseIf number=(equalNumber)
		if currentitem=newitem
			set currentitem (TRUE)
		else
			set currentitem (FALSE)
		endelse
	ElseIf number=(inequalNumber)
		if currentitem!=newitem
			set currentitem (TRUE)
		else
			set currentitem (FALSE)
		endelse
	ElseIf number=(lessNumber)
		if currentitem<newitem
			set currentitem (TRUE)
		else
			set currentitem (FALSE)
		endelse
	ElseIf number=(greaterNumber)
		if currentitem>newitem
			set currentitem (TRUE)
		else
			set currentitem (FALSE)
		endelse
	ElseIf number=(lessequalNumber)
		if currentitem<=newitem
			set currentitem (TRUE)
		else
			set currentitem (FALSE)
		endelse
	ElseIf number=(greaterequalNumber)
		if currentitem>=newitem
			set currentitem (TRUE)
		else
			set currentitem (FALSE)
		endelse
	ElseIf number=(andlogicalNumber)
		if currentitem!=(FALSE)
			if newitem!=(FALSE)
				set currentitem (TRUE)  #example: is 7 will be 1
			else
				set currentitem (FALSE)
			endelse
		endif
	ElseIf number=(orlogicalNumber)
		if currentitem!=(FALSE)
			set currentitem (TRUE)
		elseif newitem!=(FALSE)
			set currentitem (TRUE)
		endelseif
	ElseIf number=(unsignedlessNumber)
		if currentitem<^newitem
			set currentitem (TRUE)
		else
			set currentitem (FALSE)
		endelse
	ElseIf number=(unsignedgreaterNumber)
		if currentitem>^newitem
			set currentitem (TRUE)
		else
			set currentitem (FALSE)
		endelse
	ElseIf number=(unsignedlessequalNumber)
		if currentitem<=^newitem
			set currentitem (TRUE)
		else
			set currentitem (FALSE)
		endelse
	ElseIf number=(unsignedgreaterequalNumber)
		if currentitem>=^newitem
			set currentitem (TRUE)
		else
			set currentitem (FALSE)
		endelse
	ElseIf number=(parityNumber)
		if currentitem!newitem
			set currentitem (TRUE)
		else
			set currentitem (FALSE)
		endelse
	Else
	#If number=(oddNumber)
		if currentitem!!newitem
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
	ElseIf byte=(parityNumber)
	ElseIf byte=(equalNumber)
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

	#with cursor adjuster for errors
	SetCall errptr operation(#initial,size,val,op)
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
			if errptr!=(noerror)
				set ptrcontent# content  ##for error marker
				return errptr
			endif
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
			if nr!=(divNumber)
				if nr!=(remNumber)
					if nr!=(parityNumber)
						#Why does && (AND) have higher priority over || (OR) operator?
						#C++ does it that way because C did it that way.
						#and is somehow like multiplication
						#or is somehow like addition
						if nr!=(andNumber)
							if nr!=(orNumber)
								ret
							endif
							set content pcontent#
							inc content
							if content!=end ##error is catched how was before
								if content#=(orNumber)
									set pnr# (orlogicalNumber)
									set pcontent# content
								endif
							endif
						else
							set content pcontent#
							inc content
							if content!=end
								if content#=(andNumber)
									set pnr# (andlogicalNumber)
									set pcontent# content
								endif
							endif
						endelse
					else
						set content pcontent#
						inc content
						if content!=end
							if content#=(equalNumber)
								set pnr# (inequalNumber)
								set pcontent# content
							elseif content#=(parityNumber)
								set pnr# (oddNumber)
								set pcontent# content
							endelseif
						endif
					endelse
				else
					set content pcontent#
					inc content
					if content!=end
						if content#=(remNumber)
							set pnr# (remuNumber)
							set pcontent# content
						endif
					endif
				endelse
			else
				set content pcontent#
				inc content
				if content!=end
					if content#=(divNumber)
						set pnr# (divuNumber)
						set pcontent# content
					endif
				endif
			endelse
		else
			set content pcontent#
			inc content
			if content!=end
				if content#=(greaterNumber)
					set pcontent# content
					inc content
					if content!=end ##else is an error and 'set pnr#' is not important
						if content#!=(greaterNumber)
							set pnr# (sarNumber)
						else
							set pnr# (shrNumber)
							set pcontent# content
						endelse
					endif
				elseif content#=(equalNumber)
					set pcontent# content
					inc content
					if content!=end
						if content#!=(castascii)
							set pnr# (greaterequalNumber)
						else
							set pnr# (unsignedgreaterequalNumber)
							set pcontent# content
						endelse
					endif
				elseif content#=(castascii)
					set pnr# (unsignedgreaterNumber)
					set pcontent# content
				endelseif
			endif
		endelse
	else
		set content pcontent#
		inc content
		if content!=end
			if content#=(lessNumber)
				set pnr# (shlNumber)
				set pcontent# content
			elseif content#=(equalNumber)
				set pcontent# content
				inc content
				if content!=end
					if content#!=(castascii)
						set pnr# (lessequalNumber)
					else
						set pnr# (unsignedlessequalNumber)
						set pcontent# content
					endelse
				endif
			elseif content#=(castascii)
				set pnr# (unsignedlessNumber)
				set pcontent# content
			endelseif
		endif
	endelse
endfunction
