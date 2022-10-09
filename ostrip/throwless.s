
function frees()
	valuex exefile#1
	const pexefile^exefile
	if exefile!=(NULL)
		call fclose(exefile)
		valuex exedata#section_nr_of_values
		const pexedata^exedata
		if exedata!=(NULL)
			call free(exedata)
			valuex exetext#section_nr_of_values
			const pexetext^exetext
			if exetext!=(NULL)
				call free(exetext)
			endif
		endif
		valuex objects#1
		const pobjects^objects
		if objects!=(NULL)
			call freeobjects(objects)
			call free(objects)
		endif
	endif
endfunction
function freeobjects(sv objects)
	while objects#!=(NULL)
		call freeobject(objects#)
		call free(objects#)
		add objects :
	endwhile
endfunction
function freeobject(sv object)
	sd end=object_alloc
	add end object
	while object!=end
		if object#!=(NULL)
			call free(object#)
		else
			ret
		endelse
		add object (section_alloc)
	endwhile
endfunction

#file

#pos/-1
function shnames_find(ss mem,sd end,sd str)
	sd pos=0
	while mem!=end
		sd cmp;setcall cmp strcmp(mem,str)
		if cmp==0
			return pos
		endif
		addcall mem strlen(mem)
		inc mem
		inc pos
	endwhile
	return -1
endfunction
