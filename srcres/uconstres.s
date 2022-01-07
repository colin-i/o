
function uconst_miniresolve()
	sd f
	setcall f root_file()
	#spin through old declared
	call uconstres_spin(f)
endfunction

function uconstres_spin(sv f)
	sd cont
	set cont f
	add f (size_cont)
	sd cursor
	set cursor f#
	add f :
	set f f#d^
	add f cursor
	sd fls%files_p
	while cursor!=f
		sv pointer;set pointer fls
		add pointer cursor#
		call uconstres_spin(pointer#)
		add cursor (dword)
	endwhile
	#resolve doubleunuseds
	add cont (3*size_cont)
	sd double
	set double cont
	add double (size_cont+:)
	if double#!=0
		sub double :
		value aux#1;data *#1
		call memcpy(#aux,cont,(size_cont))
		call memcpy(cont,double,(size_cont))
		call memcpy(double,#aux,(size_cont))
		set cont double
	endif
	add cont :
	sd size
	set size cont#
	if size!=0
		sub cont :
		neg size
		call ralloc(cont,size)
	endif
endfunction
