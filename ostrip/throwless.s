
function frees()
	valuex exefile#1
	const pexefile^exefile
	if exefile!=(NULL)
		call fclose(exefile)
	endif
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
