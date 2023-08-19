
const Xfile_comment=0
const Xfile_multicomment=1

#err
function xfile_add(sd type,sd start,sd end)
	if main.xfile!=(openno)
		sd err;setcall err writefile_errversion(main.xfile,#type,(bsz))
		if err==(noerror)
			sub end start
			setcall err writefile_errversion(main.xfile,#end,(dwsz))
			if err==(noerror)
				setcall err writefile_errversion(main.xfile,start,end)
			endif
		endif
		return err
	endif
	return (noerror)
endfunction
function xfile_add_comment(sd start,sd end)
	if main.parses==(pass_init)
		inc start ##one for commentascii
		sd e;setcall e xfile_add((Xfile_comment),start,end)
		return e
	endif
	return (noerror)
endfunction
function xfile_add_comment_multi(sd start,sd end)
	if main.parses==(pass_init)
		add start 2 #one for commentascii and one for asciiexclamationmark
		sd e;setcall e xfile_add((Xfile_multicomment),start,end)
		return e
	endif
	return (noerror)
endfunction
