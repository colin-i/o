
function reloc_sort(sv pointer,sv end,sv dest,sd diff)
	add end diff

	sv start;set start pointer
	while start!=end
		set pointer start

		add pointer diff

		sd min;set min pointer#
		sd pos;set pos pointer
		add pointer (rel_size)
		while pointer!=end
			if pointer#<^min
				set min pointer#
				set pos pointer
			endif
			add pointer (rel_size)
		endwhile

		sub pos diff

		call memcpy(dest,pos,(rel_size))
		add dest (rel_size)
		if start!=pos
		#to fill the gap
			call memcpy(pos,start,(rel_size))
		endif
		add start (rel_size)
	endwhile
endfunction

#goodoffset
function reloc_dyn_value(sd wrongoffset)
	valuex objects#1
	valuex srcstart#1
	valuex srcmid#1
	valuex srcend#1
	valuex destd#1
	valuex destdnext#1
	valuex destv#1
	valuex destvnext#1

	if wrongoffset>=srcmid
	#virtual
		sub wrongoffset srcmid
		add wrongoffset destv
		return wrongoffset
	endif
	#file
	sub wrongoffset srcstart
	add wrongoffset destd
	return wrongoffset
endfunction

#datavaddr
function reloc_dyn_initobj(sd datavaddr)
	set reloc_dyn_value.destd reloc_dyn_value.destdnext
	set reloc_dyn_value.destv reloc_dyn_value.destvnext
	set reloc_dyn_value.srcstart datavaddr

	sv obj;set obj reloc_dyn_value.objects#
	add obj (to_data_extra)
	sd herevirtual;set herevirtual obj#d^
	set reloc_dyn_value.srcmid datavaddr
	add reloc_dyn_value.srcmid herevirtual
	add reloc_dyn_value.destdnext herevirtual
	add obj (from_data_extra_to_data_extra_sz)
	sub herevirtual obj#
	neg herevirtual
	add reloc_dyn_value.destvnext herevirtual

	add obj (from_data_extra_sz_to_data_extra_sz_a)
	add datavaddr obj#
	set reloc_dyn_value.srcend datavaddr

	return datavaddr
endfunction

function reloc_iteration(sv pointer,sd end,sd datavaddr,sd datavaddrend,sd diff)
	#this is called in all 3 cases (even only at addends there is virtual)
	add pointer diff
	add end diff
	#find the minimum and the maximum
	while pointer!=end
		if pointer#>=datavaddr
			break
		endif
		add pointer (rel_size)
	endwhile
	if pointer!=end
		#can be .text after .data
		sv cursor;set cursor pointer
		while pointer!=end
			if pointer#>=datavaddrend
				break
			endif
			add pointer (rel_size)
		endwhile
		if cursor!=pointer
			set reloc_dyn_value.objects frees.objects
			set reloc_dyn_value.destdnext datavaddr
			set reloc_dyn_value.destvnext frees.exedatasize
			add reloc_dyn_value.destvnext datavaddr
			setcall datavaddr reloc_dyn_initobj(datavaddr)
			while cursor!=pointer
				sd offset;set offset cursor#
				while offset>=reloc_dyn_value.srcend
					incst reloc_dyn_value.objects
					setcall datavaddr reloc_dyn_initobj(datavaddr)
				endwhile
				setcall cursor# reloc_dyn_value(offset)
				add cursor (rel_size)
			endwhile
		endif
	endif
endfunction
