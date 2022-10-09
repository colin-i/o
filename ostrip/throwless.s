
function frees()
	valuex exefile#1
	const pexefile^exefile
	if exefile!=(NULL)
		call fclose(exefile)
		valuex exedata#1
		const pexedata^exedata
		if exedata!=(NULL)
			call free(exedata)
			valuex exetext#1
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
		sv object;set object objects#
		sd end=object_allocs
		add end object
		while object!=end
			if object#!=(NULL)
				call free(object#)
			endif
			add object :
		endwhile
		call free(objects#)
		add objects :
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
