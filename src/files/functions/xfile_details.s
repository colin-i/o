
#err
function xfile_add_declare(ss content,sd size)
	if main.xfile!=(openno)
		sd err
		if content#==(throwlesssign)
			setcall err xfile_add_char((Xfile_declfeature_throwless))
			call stepcursors(#content,#size)
		elseif content#==(unrefsign)
			setcall err xfile_add_char((Xfile_declfeature_unref))
			call stepcursors(#content,#size)
		else
			setcall err xfile_add_char((Xfile_declfeature_normal))
		endelse
		if err==(noerror)
			setcall err xfile_add_string(content,size)
#			if sign!=(sign_not_required)
#				if err==(noerror)
#					if sign==(assignsign)
#						if reloc==(FALSE)
#						const Xfile_declsign_equal=0
#						else
#						const Xfile_declsign_reloc=1
#						endelse
#					elseif sign==(reserveascii)
#					const Xfile_declsign_reserve=2
#					elseif sign==(pointersigndeclare)
#					const Xfile_declsign_pointer=3
#					else
#					#if sign==(nosign) reserve
#					endelse
#				endif
#			endif
		endif
		return err
	endif
	return (noerror)
endfunction
