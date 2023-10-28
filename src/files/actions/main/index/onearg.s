

if parses==(pass_init)
	setcall errormsg getarg(pcontent,pcomsize,comsize,(allow_later),(FORWARD)) #there are 3 more arguments but are not used
else
	call entryscope_verify_code()
	SetCall errormsg xfile_add_char_if((Xfile_action))
	if errormsg==(noerror)
		SetCall errormsg argument(pcontent,pcomsize,(FORWARD),subtype)
	endif
endelse
