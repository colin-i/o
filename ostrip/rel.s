

function reloc(sv objects)
	while objects#!=(NULL)
		sv object;set object objects#
		call reloc_sec(object) #reladata
		add object (section_alloc)
		call reloc_sec(object) #relatext
		incst objects
	endwhile
endfunction

function reloc_sec(sv object)
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
		datax type#1;set type pointer#d^
		if type==(R_X86_64_64)
	#		if obj_offset>=obj_virtual
	#			add obj_offset total_virtual
	#		else
	#			add obj_offset total_phisic
	#		endelse
	#		set databin# obj_offset
		endif
		add pointer (datasize+datasize+:)
	endwhile
endfunction
