
value scopesbag#1
const scopesbag_ptr^scopesbag
function scopes_free()
	sv s%scopesbag_ptr
	if s#!=(NULL)
		call free(s#)
	endif
endfunction

#err
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
	setcall s# memalloc(i)
	set s s#
	if s!=(NULL)
		if has_named_entry==(TRUE)
			#entry tag is, and is last, entry. can be used in functions
			add s i
			sub s :
			sd scps%ptrscopes
			set s# scps
		endif
		return (noerror)
	endif
	return (error)
endfunction

function scopes_get_scope(sd i)
	sv s%scopesbag_ptr
	set s s#
	mult i :
	add s i
	return s#
endfunction
