

function reloc(sv objects)
	sv voffset%pexedatasize
	set voffset voffset#
	sd doffset=0
	while objects#!=(NULL)
		sv object;set object objects#
		sd d;set d object
		add object (section_alloc)

		sd t;set t object
		add object (section_alloc)

		sd voffset_obj;set voffset_obj object#d^
		add object (datasize)

		call reloc_sec(d,doffset,voffset,voffset_obj)
		call reloc_sec(t,doffset,voffset,voffset_obj)

		sv vsize_obj;set vsize_obj object#
		sub vsize_obj voffset

		add doffset voffset_obj
		add voffset vsize_obj

		incst objects
	endwhile
endfunction

function reloc_sec(sv object,sd doffset,sd voffset,sd voffset_obj)
	sv pointer;set pointer object#
	incst object
	sd end;set end object#
	add end pointer
	while pointer!=end
#		Data elf64_r_offset#1;data *=0
#		data elf64_r_info_type#1
#		data elf64_r_info_symbolindex#1
#		data elf64_r_addend#1;data *=0
	#	sv rel_offset;set rel_offset pointer#
		incst pointer
		if pointer#d^==(R_X86_64_64)
			add pointer (datasize)
			if pointer#d^==(dataind)
				add pointer (datasize)
				sv addend;set addend pointer#
				if addend>=voffset_obj
					add addend voffset
				else
					add addend doffset
				endelse
	#			add rel_offset section
	#			set rel_offset# addend
			else
				add pointer (datasize+:)
			endelse
		else
			add pointer (datasize+datasize+:)
		endelse
	endwhile
endfunction
