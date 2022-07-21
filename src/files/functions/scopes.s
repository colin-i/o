
value scopesbag#1
data *scopesbag_size#1
const scopesbag_ptr^scopesbag
function scopes_free()
	sv s%scopesbag_ptr
	if s#!=(NULL)
		sv start;set start s#
		add s :
		sv pointer;set pointer s#d^
		add pointer start
		if start!=pointer
			sub pointer :
			sd scps%ptrscopes
			if pointer#!=scps
				add pointer :
			endif
			#else let named entry like it was
			while start!=pointer
				sub pointer :
				sv cursor;set cursor pointer#
				sv cursor_last=numberofvars
				mult cursor_last :
				add cursor_last cursor
				while cursor!=cursor_last
					add cursor :
				endwhile
				call free(pointer#)
			endwhile
		endif
		call free(start)
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
	setcall s# memcalloc(i)
	sv start;set start s#
	if start!=(NULL)
		add s :
		set s# i
		sv pointer;set pointer start
		add pointer i
		if has_named_entry==(TRUE)
			#entry tag is, and is last, entry. can be used in functions
			sub pointer :
			sd scps%ptrscopes
			set pointer# scps
		endif
		#alloc some dummy values
		while start!=pointer
			sub pointer :
			setcall pointer# memcalloc((sizeofscope)) #is calloc, needing reg 0, in case it is searched
		endwhile
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

function scopes_store(sv scope)
	sv s%scopesbag_ptr
	mult scope :
	add scope s#
	set scope scope#
	sd j=0
	while j<(numberofvars)
		inc j
	endwhile
endfunction
