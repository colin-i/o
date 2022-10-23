

function reloc_dyn()
	sd pointer;set pointer frees.execreladyn
	sd end;set end frees.execreladynsize
	add end pointer
	while pointer!=end
		add pointer (rel_to_type)
		if pointer#==(R_X86_64_64)
			sub pointer (rel_to_type)
			call reloc_dyn_imps(pointer,end)
			ret
		endif
		add pointer (rel_size-rel_to_type)
	endwhile
endfunction

function reloc_dyn_imps(sv pointer,sd end)
	while pointer!=end
		add pointer (rel_size)
	endwhile
endfunction
