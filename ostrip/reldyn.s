

function reloc_dyn(sd datavaddrstart,sd datavaddrend)
	sd pointer;set pointer frees.execreladyn
	add pointer (rel_to_type)
	sd end;set end frees.execreladynsize
	add end pointer
	sd start
	while pointer!=end
		if pointer#==(R_X86_64_64)
			set start pointer
			setcall pointer reloc_dyn_sort(pointer,end,(R_X86_64_64),0)
			call reloc_iteration(start,pointer,datavaddrstart,datavaddrend,-rel_to_type)
			call verbose((verbose_flush))
		elseif pointer#==(R_X86_64_RELATIVE)
			#sort by addend then by offset to let at offset, at start probably is at offset but who cares
			set start pointer
			#by addend
			sd group;setcall group reloc_dyn_sort(pointer,end,(R_X86_64_RELATIVE),(rel_to_addend))
			call reloc_iteration(start,group,datavaddrstart,datavaddrend,(rel_from_type_to_addend))
			call verbose((verbose_flush))
			#by offset
			setcall pointer reloc_dyn_sort(pointer,end,(R_X86_64_RELATIVE),0)
			call reloc_iteration(start,pointer,datavaddrstart,datavaddrend,-rel_to_type)
			call verbose((verbose_flush))
		else
			add pointer (rel_size)
		endelse
	endwhile
endfunction

#pointer
function reloc_dyn_sort(sd pointer,sd end,sd type,sd diff)
	sv start=-rel_to_type;add start pointer
	while pointer!=end
		if pointer#!=type
			break
		endif
		add pointer (rel_size)
	endwhile

	sd return;set return pointer

	sub pointer (rel_to_type)
	sd size;set size pointer
	sub size start
	sv mem;setcall mem alloc(size)
	call reloc_sort(start,pointer,mem,diff)
	call memcpy(start,mem,size)
	call free(mem)

	return return
endfunction
