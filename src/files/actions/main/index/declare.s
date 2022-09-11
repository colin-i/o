
Data valsize#1
Chars sign#1

if subtype==(cVDATA)
	setcall errormsg getsign(content,comsize,#sign,(integersnumber),(FALSE),#valsize,#relocbool)
	if errormsg==(noerror)
		if p_is_for_64_value#==(TRUE)
			SetCall errormsg dataassign(pcontent,pcomsize,(integersnumber),(datapointbit),sign,valsize)
		else
			SetCall errormsg dataassign(pcontent,pcomsize,(integersnumber),0,sign,valsize)
		endelse
	endif
elseif subtype==(cVSTR)
	setcall errormsg getsign(content,comsize,#sign,(stringsnumber),(FALSE),#valsize,#relocbool)
	if errormsg==(noerror)
		if p_is_for_64_value#==(TRUE)
			SetCall errormsg dataassign(pcontent,pcomsize,(stringsnumber),(datapointbit),sign,valsize)
		else
			SetCall errormsg dataassign(pcontent,pcomsize,(stringsnumber),0,sign,valsize)
		endelse
	endif
elseif subtype==(cVALUE)
	setcall errormsg getsign(content,comsize,#sign,(integersnumber),(FALSE),#valsize,#relocbool)
	if errormsg==(noerror)
		if p_is_for_64_value#==(TRUE)
			SetCall errormsg dataassign(pcontent,pcomsize,(integersnumber),(valueslongmask),sign,valsize)
		else
			SetCall errormsg dataassign(pcontent,pcomsize,(integersnumber),0,sign,valsize)
		endelse
	endif
else
	sd declare_typenumber
	setcall declare_typenumber commandSubtypeDeclare_to_typenumber(subtype)
	sd is_stack
	sd typenumber
	setcall typenumber stackfilter(declare_typenumber,#is_stack)
	setcall errormsg getsign(content,comsize,#sign,typenumber,is_stack,#valsize,#relocbool)
	if errormsg==(noerror)
		if is_stack==true
			#must be at the start
			call entryscope_verify_code()
		endif
		SetCall errormsg dataassign_ex(pcontent,pcomsize,typenumber,0,is_stack,sign,valsize)
	endif
endelse
