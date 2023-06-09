
#err
function writeret()
	sd err
	sd termswitch
	sd continuation
	sd continuationsize
	setcall termswitch is_linux_end()
	if termswitch==(TRUE)
		setcall err getexit(#continuation,#continuationsize)
		if err==(noerror)
			Data ptrcodesec%%ptr_codesec
			setcall err addtosec(continuation,continuationsize,ptrcodesec)
		endif
	else
		setcall continuationsize getreturn(#continuation)
		setcall err addtosec(continuation,continuationsize,ptrcodesec)
	endelse
	return err
endfunction
