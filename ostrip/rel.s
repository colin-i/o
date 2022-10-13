

function reloc(sv objects,sd daddr)
	sd doffset;set doffset daddr
	sv voffset%pexedatasize;   #this is after the new size was set
	set voffset voffset#
	add voffset daddr
	sv dphisic%pexedata
	set dphisic dphisic#
	sv tphisic%pexetext
	set tphisic tphisic#
	while objects#!=(NULL)
		sv object;set object objects#
		sd d;set d object
		add object (section_alloc)

		sd t;set t object
		add object (section_alloc)

		sd voffset_obj;set voffset_obj object#d^
		add object (datasize)

		sv vsize_obj;set vsize_obj object#
		sub vsize_obj voffset
		incst object

		call reloc_sec(d,doffset,voffset,voffset_obj,dphisic)
		call reloc_sec(t,doffset,voffset,voffset_obj,tphisic)

		add doffset voffset_obj
		add voffset vsize_obj
		add dphisic voffset_obj
		addcall tphisic objs_align(object#)

		incst objects
	endwhile
endfunction

function reloc_sec(sv object,sd doffset,sd voffset,sd voffset_obj,sd soffset)
	sv pointer;set pointer object#
	incst object
	sd end;set end object#
	add end pointer
	while pointer!=end
#		Data elf64_r_offset#1;data *=0
#		data elf64_r_info_type#1
#		data elf64_r_info_symbolindex#1
#		data elf64_r_addend#1;data *=0
		sv rel_offset;set rel_offset pointer#
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
				add rel_offset soffset
				set rel_offset# addend
			else
				add pointer (datasize+:)
			endelse
		else
			add pointer (datasize+datasize+:)
		endelse
	endwhile
endfunction
