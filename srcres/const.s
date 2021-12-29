

function constant_add(sd s,sd sz)
	sv lvs%levels_p
	sv p=-dword
	add p lvs#d^
	add lvs (dword)
	add p lvs#
	set p p#d^
	mult p :
	sv fls%files_vp
	add p fls#
	set p p#
	call addtocont(p,s,sz)
endfunction

function incrementfiles()
	sv lvs%levels_p
	sd cursor
	set cursor lvs#d^
	call ralloc(lvs,(dword))
	add lvs (dword)
	add cursor lvs#
	setcall cursor# filessize()
endfunction

function decrementfiles()
	sd lvs%levels_p
	call ralloc(lvs,(-dword))
endfunction

#sz
function filessize()
	sd fls%files_p
	set fls fls#
	div fls :
	return fls
endfunction

#sz
function constssize()
	sv cursor%files_p
	sd end
	set end cursor#d^
	add cursor (dword)
	set cursor cursor#
	add end cursor
	sd sz=0
	while cursor!=end
		addcall sz constssize_file(cursor#)
		incst cursor
	endwhile
	return sz
endfunction
#sz
function constssize_file(sd cursor)
	sd end
	set end cursor#
	add cursor (dword)
	set cursor cursor#v^
	add end cursor
	sd sz=0
	while cursor!=end
		add cursor cursor#
		add cursor (dword)
		inc sz
	endwhile
	return sz
endfunction
