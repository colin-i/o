

function reloc_dyn()
	sd pointer;set pointer frees.execreladyn
	add pointer (rel_to_type)
	sd end;set end frees.execreladynsize
	add end pointer
	while pointer!=end
		if pointer#==(R_X86_64_64)
			setcall pointer reloc_dyn_imps(pointer,end)
		else
			add pointer (rel_size-rel_to_type)
		endelse
	endwhile
endfunction

#pointer
function reloc_dyn_imps(sv pointer,sd end)
	while pointer!=end
		if pointer#!=(R_X86_64_64)
			return pointer
		endif
		add pointer (rel_size-rel_to_type)
		call verbose((verbose_count))
	endwhile
	call verbose((verbose_flush))
endfunction
