

if parses!=(pass_write)
	SetCall errormsg twoargs_ex(pcontent,pcomsize,subtype,null,(allow_later_sec),parses)
else
	call entryscope_verify_code()
	SetCall errormsg twoargs(pcontent,pcomsize,subtype,null)
endelse
