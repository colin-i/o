
function frees()
	valuex exefile#1
	const pexefile^exefile
	if exefile!=(NULL)
		call fclose(exefile)
	endif
endfunction


#file

#number of sections
function shnames_total(ss mem,sd end)
	add end mem
	sd nr=0
	while mem!=end
		if mem#==(asciiNUL)
			inc nr
		endif
		inc mem
	endwhile
	return nr
endfunction

function shnames_pin(ss mem,sd end,sv offsets)
	sd start;set start mem
	add end mem
	while mem!=end
		if mem#==(asciiNUL)
			sd snap;set snap mem
			sub snap start
			set offsets# snap
			add offsets :
		endif
		inc mem
	endwhile
endfunction
