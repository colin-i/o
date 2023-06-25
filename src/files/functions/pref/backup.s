
function pref_store()
	sv src%nr_of_prefs_pointers_p
	sd dest%prefs_backup_p

	sd max=nr_of_prefs_jumper
	add max src
	while src!=max
		sd p;set p src#
		set dest# p#
		incst src
		add dest (dwsz)
	endwhile
endfunction

function pref_restore()
	sd src%prefs_backup_p
	sv dest%nr_of_prefs_pointers_p

	sd max=nr_of_prefs_jumper
	add max dest
	while dest!=max
		sd p;set p dest#
		set p# src#
		incst dest
		add src (dwsz)
	endwhile
endfunction

function backup_pref(sd p_formatdefined)
	set p_formatdefined# 1
	call pref_store() #this must be after "set nobits_virtual"
endfunction
