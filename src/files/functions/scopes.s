
value scopesbag#1
const scopesbag_ptr^scopesbag
function scopes_free()
	sv s%scopesbag_ptr
	if s#!=(NULL)
		call free(s#)
	endif
endfunction

function scopes_alloc(sd has_named_entry)
	sv ptrfunctions%ptrfunctions
	sd i=0
	sd fns
	sv last
	call getcontandcontReg(ptrfunctions,#fns,#last)
	add last fns
	while fns!=last
		add fns (nameoffset)
		addcall fns strlen(fns)
		inc fns
		inc i
	endwhile
	mult i :
	sv s%scopesbag_ptr
	sd err
	setcall err memrealloc(s,i)
	if err==(noerror)
		if has_named_entry==(TRUE)
			#entry tag is, and is last, entry. can be used in functions
			set s s#
			add s i
			sub s :
			sd scps%ptrscopes
			set s# scps
		endif
	endif
	return err
endfunction

function scopes_get_scope(sd i)
	sv s%scopesbag_ptr
	set s s#
	mult i :
	add s i
	return s#
endfunction
