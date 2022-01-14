

#err
function elfobj_resolve(sd p_localsyms,sd cont,sd end,sd entsize,sd datacont,sd dataend,sd textcont,sd textend,sd relsize)
	add end cont
	#
	sd st_info_offset
	sd info_symbolindex_offset
	sd info_symbolindex_size
	if entsize==(elf64_dyn_d_val_syment)
		set st_info_offset (elf64_sym_st_info_offset)
		set info_symbolindex_offset (elf64_r_info_symbolindex_offset)
		set info_symbolindex_size (elf64_r_info_symbolindex_size)
	else
		set st_info_offset (elf32_sym_st_info_offset)
		set info_symbolindex_offset (elf_r_info_symbolindex_offset)
		set info_symbolindex_size (elf_r_info_symbolindex_size)
	endelse
	#iterate left right stop on global
	sd first_global
	setcall first_global elfobj_resolve_lr(cont,end,entsize,st_info_offset)
	#iterate right left stop on local
	sd last_local_margin
	setcall last_local_margin elfobj_resolve_rl(cont,end,entsize,st_info_offset)
	if first_global!=last_local_margin
		sd alloc
		sd localindex
		#count local/global
		setcall p_localsyms# elfobj_resolve_count(first_global,last_local_margin,entsize,st_info_offset,cont,#alloc,#localindex)
		#alloc global aux
		sd sz
		set sz entsize
		mult sz alloc
		sd err
		setcall err memoryalloc(sz,#alloc)
		if err!=(noerror)
			return err
		endif
		#iterate inside
		sd pos
		sd localpos
		set pos alloc
		set localpos first_global
		sd globalindex
		sd index
		set globalindex p_localsyms#
		set index localindex
		#
		add dataend datacont
		add textend textcont
		while first_global!=last_local_margin
			sd comp
			setcall comp elfobj_resolve_stbcomp(first_global,st_info_offset,(STB_GLOBAL))
			if comp==(TRUE)
				#if global put on aux
				call memtomem(pos,first_global,entsize)
				add pos entsize
				#with the entry, modify index in rel data/text
				call elffobj_resolve_relmodif(index,globalindex,datacont,dataend,textcont,textend,relsize,info_symbolindex_offset,info_symbolindex_size)
				inc globalindex
			else
				#if local put on position
				call memtomem(localpos,first_global,entsize)
				add localpos entsize
				#
				call elffobj_resolve_relmodif(index,localindex,datacont,dataend,textcont,textend,relsize,info_symbolindex_offset,info_symbolindex_size)
				inc localindex
			endelse
			add first_global entsize
			inc index
		endwhile
		#at end, put globals
		call memtomem(localpos,alloc,sz)
		call free(alloc)
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

#n
function elfobj_resolve_count(sd a,sd b,sd sz,sd of,sd origin,sd p_alloc,sd old_index)
	sub origin a
	neg origin
	div origin sz
	set old_index# origin
	add a sz #a is first global
	sd g=1
	while a!=b
		sd comp
		setcall comp elfobj_resolve_stbcomp(a,of,(STB_LOCAL))
		if comp==(TRUE)
			inc origin
		else
			inc g
		endelse
		add a sz
	endwhile
	set p_alloc# g
	return origin
endfunction

function elffobj_resolve_relmodif(sd oldindex,sd newindex,sd datacont,sd dataend,sd textcont,sd textend,sd relsize,sd offset,sd infsize)
	call elfobj_resolve_relmodif_section(oldindex,newindex,datacont,dataend,relsize,offset,infsize)
	call elfobj_resolve_relmodif_section(oldindex,newindex,textcont,textend,relsize,offset,infsize)
endfunction
function elfobj_resolve_relmodif_section(sd oldindex,sd newindex,sd cont,sd end,sd size,sd offset,sd infsize)
	while cont!=end
		sd a
		set a cont
		add a offset
		sd c
		setcall c memtomem(a,oldindex,infsize)
		if c==0
			call memtomem(a,newindex,infsize)
		endif
		add cont size
	endwhile
endfunction
