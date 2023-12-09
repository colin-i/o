

Data quotsz#1
Data escapes#1
Data pquotsz^quotsz
Data pescapes^escapes

SetCall errormsg xfile_add_char_ifif((Xfile_include))
if errormsg=noerr
	SetCall errormsg quotinmem(pcontent,pcomsize,pquotsz,pescapes) #there are: include "a a" "b b"
	if errormsg=noerr
		SetCall errormsg xfile_add_char_ifif(subtype)
		if errormsg=noerr
			if include_sec=(TRUE)
				ss include_test
				set include_test content
				add include_test quotsz
				inc include_test
				setcall include_test mem_spaces(include_test,pointer)
				if include_test!=pointer
					if include_test#=(asciidoublequote)
						SetCall errormsg addtosecstresc_xfile(pcontent,pcomsize,quotsz,escapes,ptrtempdata) #is ok with casts, at misc if set must set reg 0
						if errormsg=noerr
							sub include_test content
							sub comsize include_test
							add content include_test
							SetCall errormsg quotinmem(pcontent,pcomsize,pquotsz,pescapes)
							if errormsg=noerr
								SetCall errormsg xfile_add_char_ifif((Xfile_include_alternative_yes))
							endif
						endif
					else
						setcall errormsg xfile_add_char_ifif((Xfile_include_alternative_no))
					endelse
				endif
			endif
			if errormsg=noerr
				SetCall errormsg addtosecstresc_xfile(pcontent,pcomsize,quotsz,escapes,ptrmiscbag)
				If errormsg=noerr
					Set includebool one
					if include_sec=(FALSE)
						SetCall errormsg include_sec_skip(pcontent,pcomsize)
					endif
				EndIf
			endif
		endif
	EndIf
endif
