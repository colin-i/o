
setcall errormsg xfile_add_callret_ifif(subtype)
if errormsg==(noerror)
	Data callfn=callfunction
	SetCall errormsg parsefunction(pcontent,pcomsize,callfn,subtype) #there are 2 more arguments but are not used
	if parses==(pass_write)
		if errormsg==(noerror)
			setcall errormsg after_after_call(subtype)
		endif
	endif
endif
