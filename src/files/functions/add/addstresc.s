

#errnr
Function addtosecstresc(sd pcontent,sd psize,sd sz,sd escapes,sd pdest,sd wordpad)
	sd err;setcall err addtosecstresc_base(pcontent,psize,sz,escapes,pdest,wordpad,(FALSE))
	return err
endFunction
#errnr
Function addtosecstresc_xfile(sd pcontent,sd psize,sd sz,sd escapes,sd pdest)
	sd err;setcall err addtosecstresc_base(pcontent,psize,sz,escapes,pdest,(FALSE),(TRUE))
	return err
endFunction
#errnr
Function addtosecstresc_base(sd pcontent,sd psize,sd sz,sd escapes,sd pdest,sd wordpad,sd write_to_xfile)
	#set destination start
	Data destReg#1
	Data ptrdestReg^destReg
	Call getcontReg(pdest,ptrdestReg)

	Data odd#1
	Data zero=0

	# size of the string out with term
	Data sizeEsc#1
	Set sizeEsc sz
	sd end;set end sizeEsc
	Sub sizeEsc escapes
	if write_to_xfile=(TRUE)
		sd xfilesz;set xfilesz sizeEsc
	endif
	Inc sizeEsc

	Set odd zero
	#into idata string is padded to word
	If wordpad!=zero
		set odd sizeEsc
		and odd 1
		If odd!=zero
			Inc sizeEsc
		EndIf
	EndIf

	Data noerr=noerror
	Data errnr#1
	SetCall errnr addtosec(0,sizeEsc,pdest)
	If errnr!=noerr
		Return errnr
	EndIf

	#set destination start
	Str destloc#1
	Data ptrdestloc^destloc
	Call getcont(pdest,ptrdestloc)
	Add destloc destReg
	if write_to_xfile=(TRUE)
		sd xfileloc;set xfileloc destloc
	endif

	add end pcontent#
	While pcontent#!=end
		Char byte#1
		SetCall byte quotescaped(pcontent,psize,zero)
		Set destloc# byte
		Inc destloc
		Call stepcursors(pcontent,psize)
	EndWhile
	Set destloc# zero
	If odd!=zero
		Inc destloc
		Set destloc# zero
	EndIf
	#not spaces here because of arg call that adds 2 there
	if write_to_xfile=(TRUE)
		#ifif only for include tag
		setcall errnr xfile_add_string_ifif(xfileloc,xfilesz)
		return errnr
	endif

	Return (noerror)
EndFunction
