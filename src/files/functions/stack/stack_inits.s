


#mask bit
function data_get_maskbit(sd pointer,sd bit)
	add pointer (maskoffset)
	and bit pointer#
	return bit
endfunction
function importbit(sd pointer)
	sd bit
	setcall bit data_get_maskbit(pointer,(idatabitfunction))
	return bit
endfunction
function stackbit(sd pointer)
	sd bit
	setcall bit data_get_maskbit(pointer,(stackbit))
	return bit
endfunction
function stackrelativebit(sd pointer)
	sd bit
	setcall bit data_get_maskbit(pointer,(stackrelativebit))
	return bit
endfunction
function datapointbit(sd pointer)
	sd bit
	setcall bit data_get_maskbit(pointer,(datapointbit))
	return bit
endfunction
function expandbit(sd pointer)
	sd bit
	setcall bit data_get_maskbit(pointer,(expandbit))
	return bit
endfunction
function expandbit_wrap(sd pointer)
	vdata ptr_nobits_virtual%ptr_nobits_virtual
	if ptr_nobits_virtual#==(Yes)
		sd bit
		setcall bit data_get_maskbit(pointer,(expandbit))
		return bit
	endif
	return 0
endfunction
function pointbit(sd pointer)
	sd bit
	setcall bit data_get_maskbit(pointer,(pointbit))
	return bit
endfunction
function suffixbit(sd pointer)
	sd bit
	setcall bit data_get_maskbit(pointer,(suffixbit))
	return bit
endfunction

function stack_get_relative(sd location)
	sd mask
	set mask location
	add mask (maskoffset)
	set mask mask#
	and mask (stackrelativebit)
	if mask==0
		return (ebxregnumber)
	endif
	return (ebpregnumber)
endfunction
