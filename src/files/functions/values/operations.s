

Const addNumber=0
Const subNumber=1
Const mulNumber=2
Const divNumber=3
Const andNumber=4
Const orNumber=5
Const xorNumber=6
Const powNumber=7
Const remNumber=8
Const shlNumber=9
Const shrNumber=10
#asciiminus and asciinot for one arg

#err
function const_security(sd item)
	#2$31 is last one
	#1 shl 63 is last one
	#maximum first overflow, ok
	sd maximum=qwsz*8-1
	if item#>maximum
		str err="Overflow at constants."
		sd w%p_w_as_e
		if w#==(TRUE)
			sd p%p_over_pref
			if p#==(TRUE)
				return err
			endif
		endif
		call Message(err)
		set item# maximum
	endif
	return (noerror)
endfunction
#err
function shift_right(sd a,sd n)
	sd err
	setcall err const_security(#n)
	If err!=(noerror);return err;endif
	while n>0
		dec n
		shr a#
	endwhile
	return (noerror)
endfunction
#err
function shift_left(sd a,sd n)
	sd err
	setcall err const_security(#n)
	If err!=(noerror);return err;endif
	while n>0
		dec n
		shl a#
	endwhile
	return (noerror)
endfunction

#err pointer
Function operation(str content,data size,data inoutvalue,data number)
	Data newitem#1
	Data ptrnewitem^newitem
	Data initialnewitem=0
	Data errptr#1
	Data noerr=noerror

	Set newitem initialnewitem
	SetCall errptr numbersconstants(content,size,ptrnewitem)
	If errptr!=noerr
		Return errptr
	EndIf

	Data currentitem=0
	Set currentitem inoutvalue#
	If number==(addNumber)
		Add currentitem newitem
	ElseIf number==(subNumber)
		Sub currentitem newitem
	ElseIf number==(mulNumber)
		Mult currentitem newitem
	ElseIf number==(divNumber)
		Data zero=0
		If newitem==zero
			Chars zerodiv="Division by 0 error."
			Str ptrzerodiv^zerodiv
			Return ptrzerodiv
		EndIf
		Div currentitem newitem
	ElseIf number==(andNumber)
		And currentitem newitem
	ElseIf number==(orNumber)
		Or currentitem newitem
	ElseIf number==(xorNumber)
		Xor currentitem newitem
	ElseIf number==(powNumber)
		if newitem<0
			if currentitem==0
				#is 1/(0 power n)
				Return ptrzerodiv
			elseif currentitem==1
				#is 1/(1 power n)
			else
				#is 1/(>1)
				set currentitem 0
			endelse
		elseif newitem==0
			set currentitem 1
		else
			SetCall errptr const_security(#newitem)
			If errptr!=noerr;return errptr;endif
			sd item;set item currentitem
			while newitem!=1
				mult currentitem item
				dec newitem
			endwhile
		endelse
	ElseIf number==(remNumber)
		If newitem==zero
			Return ptrzerodiv
		EndIf
		Rem currentitem newitem
	ElseIf number==(shlNumber)
		if newitem<0
			neg newitem
			SetCall errptr shift_right(#currentitem,newitem)
		else
			SetCall errptr shift_left(#currentitem,newitem)
		endelse
		If errptr!=noerr;return errptr;endif
	Else
	#If number==(shrNumber)
		if newitem<0
			neg newitem
			SetCall errptr shift_left(#currentitem,newitem)
		else
			SetCall errptr shift_right(#currentitem,newitem)
		endelse
		If errptr!=noerr;return errptr;endif
	EndElse

	Set inoutvalue# currentitem
	Return noerr
EndFunction

#bool
Function signop(chars byte,data outval)
	Chars plus=asciiplus
	Chars minus=asciiminus
	Chars mult=asciiast
	Chars div=asciislash
	Chars and=asciiand
	Chars or=asciivbar
	Chars xor=asciicirc
	Chars pow=asciidollar
	Chars rem=asciipercent
	Chars shl=asciiless
	Chars shr=asciigreater

	Data false=FALSE
	Data true=TRUE

	If byte==plus
		Set outval# (addNumber)
	ElseIf byte==minus
		Set outval# (subNumber)
	ElseIf byte==mult
		Set outval# (mulNumber)
	ElseIf byte==div
		Set outval# (divNumber)
	ElseIf byte==and
		Set outval# (andNumber)
	ElseIf byte==or
		Set outval# (orNumber)
	ElseIf byte==xor
		Set outval# (xorNumber)
	ElseIf byte==pow
		Set outval# (powNumber)
	ElseIf byte==rem
		Set outval# (remNumber)
	ElseIf byte==shl
		Set outval# (shlNumber)
	ElseIf byte==shr
		Set outval# (shrNumber)
	Else
		return false
	EndElse
	Return true
EndFunction

#err
Function oneoperation(data ptrcontent,str initial,str content,data val,data op)
	Data size#1
	Data errptr#1
	Data noerr=noerror

	Set size content
	Sub size initial

	SetCall errptr operation(initial,size,val,op)
	If errptr!=noerr
		Set ptrcontent# initial
		Return errptr
	EndIf
	Return noerr
EndFunction

#err pointer
Function parseoperations(sd ptrcontent,sd ptrsize,sd sz,sd outvalue,sd comments)
	Str content#1
	Str initial#1
	Data number#1
	Data val#1
	Data ptrval^val
	Data zero=0
	Data errptr#1
	Data noerr=noerror

	Set content ptrcontent#

	Set initial content
	Set number zero
	Set val zero

	Data bool#1
	Data false=FALSE
	Data true=TRUE
	Data nr#1
	Data pnr^nr
	Chars byte#1
	Data find#1

	sd end;set end content;add end sz

	#<end?maybe unsigned cursor
	While content!=end
		Set bool false
		Set byte content#
		SetCall find signop(byte,pnr)
		If find==true
			If initial!=content
				SetCall errptr oneoperation(ptrcontent,initial,content,ptrval,number)
				If errptr!=noerr
					Return errptr
				EndIf
				Set bool true
				Set number nr
			EndIf
		EndIf
		Inc content
		If bool==true
			setcall content mem_spaces(content,end)
			Set initial content
		EndIf
	EndWhile

	#allow line end comment
	sd szz
	set szz end;sub szz initial
	if comments==(TRUE)
		sd size
		setcall size find_whitespaceORcomment(initial,szz)
		SetCall errptr operation(initial,size,ptrval,number)
	else
		SetCall errptr operation(initial,szz,ptrval,number)
	endelse
	If errptr!=noerr
		Return errptr
	EndIf
	Set outvalue# val

	if comments==(TRUE)
		sub szz size
		sub sz szz
	endif
	Call advancecursors(ptrcontent,ptrsize,sz)
	Return noerr
EndFunction
