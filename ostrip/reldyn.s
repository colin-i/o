

function reloc_dyn()
	sd pointer;set pointer frees.execreladyn
	add pointer (rel_to_type)
	sd end;set end frees.execreladynsize
	add end pointer
	while pointer!=end
		if pointer#==(R_X86_64_64)
			setcall pointer reloc_dyn_imps(pointer,end)
		else
			add pointer (rel_size)
		endelse
	endwhile
endfunction

#pointer
function reloc_dyn_imps(sd pointer,sd end)
	sv start=-rel_to_type;add start pointer
	while pointer!=end
		if pointer#!=(R_X86_64_64)
			break
		endif
		add pointer (rel_size)
		call verbose((verbose_count))
	endwhile
	call verbose((verbose_flush))

	sd return;set return pointer

	sub pointer (rel_to_type)
	sd size;set size pointer
	sub size start
	sv mem;setcall mem alloc(size)
	call reloc_sort(start,pointer,mem)
	call memcpy(start,mem,size)
	call free(mem)

	return return
endfunction
