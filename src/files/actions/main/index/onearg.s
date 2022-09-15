

Data forward=FORWARD

if parses==(pass_init)
	setcall errormsg getarg(pcontent,pcomsize,comsize,(allow_later)) #there are 4 more arguments but are not used
else
	call entryscope_verify_code()
	SetCall errormsg argument(pcontent,pcomsize,forward,subtype)
endelse
