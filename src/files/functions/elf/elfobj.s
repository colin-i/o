

#err
function elfobj_resolve(sd *p_localsyms,sd cont,sd end,sd entsize)
	add end cont
	sd st_info_offset
	if entsize==(elf64_dyn_d_val_syment)
		set st_info_offset (elf64_sym_st_info_offset)
	else
		set st_info_offset (elf32_sym_st_info_offset)
	endelse
	#iterate left right stop on global
	sd first_global
	setcall first_global elfobj_resolve_lr(cont,end,entsize,st_info_offset)
	#iterate right left stop on local
	sd last_local_margin
	setcall last_local_margin elfobj_resolve_rl(cont,end,entsize,st_info_offset)
	if first_global!=last_local_margin
		#count global to set local/global new index
		#alloc global aux
		#iterate inside
		#with the entry, modify index in rel data/text
		#if global put on aux
		#if local put on position
		#at end, put globals
	endif
	return (noerror)
endfunction

function elfobj_resolve_lr(sd cont,sd end,sd entsize,sd st_info_offset)
	while cont!=end
		#compare st_info
		sd comp
		setcall comp elfobj_resolve_stbcomp(cont,st_info_offset,(STB_GLOBAL))
		if comp==(TRUE)
			set end cont
		else
			add cont entsize
		endelse
	endwhile
	return cont
endfunction

function elfobj_resolve_rl(sd cont,sd end,sd entsize,sd st_info_offset)
	while cont!=end
		sub end entsize
		#compare st_info
		sd comp
		setcall comp elfobj_resolve_stbcomp(end,st_info_offset,(STB_LOCAL))
		if comp==(TRUE)
			add end entsize
			set cont end
		endif
	endwhile
	return end
endfunction

function elfobj_resolve_stbcomp(ss ent,sd offset,sd against)
	add ent offset
	set ent ent#
	div ent (elf_sym_st_info_tohibyte)
	if ent==against
		return (TRUE)
	endif
	return (FALSE)
endfunction
