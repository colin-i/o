
function import_leading_underscore(sv pcontent,sd pcomsize,sd ptrimpquotsz)
	sd p_underscore_pref%p_underscore_pref
	if p_underscore_pref#==(TRUE)
		ss content
		set content pcontent#
		#here it is inside quotes
		if content#==(asciiunderscore)
			call stepcursors(pcontent,pcomsize)
			dec ptrimpquotsz#
		endif
	endif
endfunction
