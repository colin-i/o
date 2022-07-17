
value scopesbag#1
const scopesbag_ptr^scopesbag
function scopes_free()
	sv s%scopesbag_ptr
	if s#!=(NULL)
		call free(s#)
	endif
endfunction

function scopes_alloc()
	sv ptrfunctions%ptrfunctions
	sd i=0
	sd fns
	sd last
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
	return err
endfunction
