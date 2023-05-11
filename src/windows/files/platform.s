
function platform_free()
	sd a%p_argv
	if a#!=(NULL)
		call free(a#)
	endif
	sd b%p_path_free
	if b#!=(NULL)
		call free(b#)
	endif
endfunction

function argv_to_ansi(sd argc,sd argv)
	mult argc :
	add argc argv
	while argv!=argc
		call wide_to_ansi(argv#)
		incst argv
	endwhile
endfunction

function wide_to_ansi(ss in)
	ss out
	set out in
	dec out
	char n=0;char x#1
	while 0==0
		inc out
		set x in#
		set out# x
		if x==n
			ret
		endif
		add in 2
	endwhile
endfunction
