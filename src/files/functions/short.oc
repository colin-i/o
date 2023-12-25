
function i_to_s(sd data,ss pshort)
	set pshort# data
	inc pshort
	div data 0x100
	set pshort# data
endfunction

function s_to_i(ss pshort)
	sd out
	set out pshort#
	inc pshort
	ss p^out
	inc p
	set p# pshort#
	return out
endfunction
