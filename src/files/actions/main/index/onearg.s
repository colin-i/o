

if parses=(pass_init)
	setcall errormsg argument_init(pcontent,pcomsize,subtype)
else
	call entryscope_verify_code()
	SetCall errormsg xfile_add_char_if((Xfile_action))
	if errormsg=(noerror)
		SetCall errormsg argument(pcontent,pcomsize,(FORWARD),subtype)
	endif
endelse
