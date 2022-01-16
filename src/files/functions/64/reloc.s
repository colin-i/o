

function reloc64_init()
	sd a%p_pref_reloc_64
	sd b%p_elf64_r_info_type
	if a#==(TRUE)
		set b# (R_X86_64_64)
	endif
	#blank is at inits
endfunction

function reloc64_offset(sd offset)
	sd a%p_elf64_r_info_type
	if a#==(R_X86_64_64)
		add offset 1
	endif
	return offset
endfunction
#er
function reloc64_ante()
	sd a%p_elf64_r_info_type
	if a#==(R_X86_64_64)
		sd err
		call rex_w(#err)
		return err
	endif
	return (noerror)
endfunction
#er
function reloc64_post()
	sd a%p_elf64_r_info_type
	if a#==(R_X86_64_64)
		sd err
		sd ptrcodesec%ptrcodesec
		sd null=0
		SetCall err addtosec(#null,(dwsz),ptrcodesec)
		return err
	endif
	return (noerror)
endfunction
