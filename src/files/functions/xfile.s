
const Xfile_sz_char=bsz
const Xfile_sz_int=dwsz

const Xfile_comment=0
const Xfile_multicomment=1
const Xfile_functiondef=2
const Xfile_declare=3

const Xfile_function_tintern=0
const Xfile_function_traw=1
	const Xfile_function_not_x=Xfile_function_traw
const Xfile_function_extern=2
const Xfile_function_entry=3

const Xfile_function_e_normal=0
const Xfile_function_e_varargs=1

const Xfile_decltype_byte=0
const Xfile_decltype_int=1
const Xfile_decltype_long=2
const Xfile_decltype_longByte=3
const Xfile_decltype_longInt=4
const Xfile_decltype_const=5

const Xfile_declfeature_normal=0
const Xfile_declfeature_unref=1
const Xfile_declfeature_throwless=2

const Xfile_declsign_equal=0
const Xfile_declsign_reloc=1
const Xfile_declsign_reserve=2
const Xfile_declsign_pointer=3

const Xfile_declmode_value=0
const Xfile_declmode_string=1
const Xfile_declmode_group=2

#[numbers_parenthesis_open] numbers_prefix_neg/not/normal numbers_type_decimal/hex/constant/long/data/vdata/sizeFunc/sizeXFunc/sizeVar/offsetVar [numbers_parenthesis_close] [numbers_operation_14] [...] numbers_done

#err
function xfile_add_int(sd int)
	if main.xfile!=(openno)
		sd err;setcall err writefile_errversion(main.xfile,#int,(Xfile_sz_int))
		return err
	endif
	return (noerror)
endfunction
function xfile_add_char(sd type)
	sd err;setcall err writefile_errversion(main.xfile,#type,(Xfile_sz_char))
	return err
endfunction
function xfile_add_char_if(sd type)
	if main.xfile!=(openno)
		sd err;setcall err writefile_errversion(main.xfile,#type,(Xfile_sz_char))
		return err
	endif
	return (noerror)
endfunction
function xfile_add_char_ifif(sd type)
	if main.parses==(pass_write)
		sd err;setcall err xfile_add_char_if(type)
		return err
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
	sd err;setcall err writefile_errversion(main.xfile,#type,(Xfile_sz_char))
	if err==(noerror)
		setcall err xfile_add_string(text,size)
	endif
	return err
endfunction
function xfile_add_base_if(sd type,sd text,sd size)
	if main.xfile!=(openno)
		sd err;setcall err xfile_add_base(type,text,size)
	endif
	return (noerror)
endfunction
function xfile_add(sd type,sd start,sd end)
	sub end start
	sd e;setcall e xfile_add_base_if(type,start,end)
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
