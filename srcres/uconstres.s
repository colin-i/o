
function uconst_miniresolve()
	sd f
	setcall f root_file()
	#spin through old declared
	call uconstres_spin(f,(TRUE))
endfunction

function uconstres_spin(sd f,sd is_new)
	sd cont
	set cont f
	add f (size_cont)
	call uconstres_search(f,(FALSE))
	add f (size_cont)
	call uconstres_search(f,is_new)
	#
	if is_new==(FALSE)
		#resolve doubleunuseds
		add f (size_cont)
		sd double
		set double f
		add double (size_cont+:)
		if double#!=0
			sub double :
			value aux#1;data *#1
			call memcpy(#aux,f,(size_cont))
			call memcpy(cont,double,(size_cont))
			call memcpy(double,#aux,(size_cont))
			set f double
		endif
		add f :
		sd size
		set size f#
		if size!=0
			sub f :
			neg size
			call ralloc(f,size)
		endif
	endif
endfunction

function uconstres_search(sv f,sd is_new)
	sd cursor
	set cursor f#
	add f :
	set f f#d^
	add f cursor
	sd fls%files_p
	while cursor!=f
		sv pointer;set pointer fls
		add pointer cursor#
		call uconstres_spin(pointer#,is_new)
		add cursor (dword)
	endwhile
endfunction
