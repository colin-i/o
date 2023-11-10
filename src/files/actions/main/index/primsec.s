

if parses!=(pass_write)
	SetCall errormsg twoargs_ex(pcontent,pcomsize,subtype,null,(allow_later_sec),parses)
else
	call entryscope_verify_code()
	SetCall errormsg xfile_add_char_if((Xfile_action2))
	if errormsg==(noerror)
		SetCall errormsg twoargs(pcontent,pcomsize,subtype,null)
	endif
endelse
