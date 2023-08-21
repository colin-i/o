
const Xfile_comment=0
const Xfile_multicomment=1
const Xfile_functiondef=2

const Xfile_sz_char=bsz
const Xfile_sz_int=dwsz

const Xfile_argtype_byte=0
const Xfile_argtype_int=1
const Xfile_argtype_long=2
const Xfile_argtype_long_byte=3
const Xfile_argtype_long_int=4

#err
function xfile_add_int(sd int)
	if main.xfile!=(openno)
		sd err;setcall err writefile_errversion(main.xfile,#int,(Xfile_sz_int))
		return err
	endif
	return (noerror)
endfunction
function xfile_add_char(sd type)
	if main.parses==(pass_write)
		if main.xfile!=(openno)
			sd err;setcall err writefile_errversion(main.xfile,#type,(Xfile_sz_char))
			return err
		endif
	endif
	return (noerror)
endfunction
function xfile_add_string(sd text,sd size)
	sd err;setcall err writefile_errversion(main.xfile,#size,(Xfile_sz_int))
	if err==(noerror)
		setcall err writefile_errversion(main.xfile,text,size)
	endif
	return err
endfunction
function xfile_add_string_if(sd text,sd size)
	if main.xfile!=(openno)
		sd err;setcall err xfile_add_string(text,size)
		return err
	endif
	return (noerror)
endfunction
function xfile_add_base(sd type,sd text,sd size)
	if main.xfile!=(openno)
		sd err;setcall err writefile_errversion(main.xfile,#type,(Xfile_sz_char))
		if err==(noerror)
			setcall err xfile_add_string(text,size)
		endif
		return err
	endif
	return (noerror)
endfunction
function xfile_add(sd type,sd start,sd end)
	sub end start
	sd e;setcall e xfile_add_base(type,start,end)
	return e
endfunction
function xfile_add_comment(sd start,sd end)
	if main.parses==(pass_write)
		inc start ##one for commentascii
		sd e;setcall e xfile_add((Xfile_comment),start,end)
		return e
	endif
	return (noerror)
endfunction
function xfile_add_comment_multi(sd start,sd end)
	if main.parses==(pass_write)
		add start 2 #one for commentascii and one for asciiexclamationmark
		sd e;setcall e xfile_add((Xfile_multicomment),start,end)
		return e
	endif
	return (noerror)
endfunction
