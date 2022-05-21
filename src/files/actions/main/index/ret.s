
sd termswitch
sd continuation
sd continuationsize
setcall termswitch is_linux_end()
if termswitch==(TRUE)
	setcall errormsg getexit(#continuation,#continuationsize)
	if errormsg==(noerror)
		setcall errormsg addtosec(continuation,continuationsize,ptrcodesec)
	endif
else
	setcall continuationsize getreturn(#continuation)
	setcall errormsg addtosec(continuation,continuationsize,ptrcodesec)
endelse
