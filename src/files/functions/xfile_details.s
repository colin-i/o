
#err
function xfile_add_declare(sd decltype,ss content,sd size,sd sign,sd reloc)
	if main.xfile!=(openno)
		sd err
		setcall err xfile_add_char(decltype)
		if err==(noerror)
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
				if sign!=(sign_not_required)
					if err==(noerror)
						if sign==(assignsign)
							if reloc==(FALSE)
								setcall err xfile_add_char((Xfile_declsign_equal))
							else
								setcall err xfile_add_char((Xfile_declsign_reloc))
							endelse
						elseif sign==(reservesign)
							setcall err xfile_add_char((Xfile_declsign_reserve))
						elseif sign==(pointersigndeclare)
							setcall err xfile_add_char((Xfile_declsign_pointer))
						else
						#if sign==(nosign) reserve
							setcall err xfile_add_char((Xfile_declsign_reserve))
						endelse
					endif
				endif
			endif
		endif
		return err
	endif
	return (noerror)
endfunction
