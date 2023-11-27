

Data quotsz#1
Data escapes#1
Data pquotsz^quotsz
Data pescapes^escapes

SetCall errormsg xfile_add_char_ifif((Xfile_include))
if errormsg=noerr
	SetCall errormsg quotinmem(pcontent,pcomsize,pquotsz,pescapes)
	if errormsg=noerr
		SetCall errormsg xfile_add_base_ifif(subtype,content,quotsz)
		if errormsg=noerr
			if include_sec=(TRUE)
				ss include_test
				set include_test content
				add include_test quotsz
				inc include_test
				setcall include_test mem_spaces(include_test,pointer)
				if include_test!=pointer
					if include_test#=(asciidoublequote)
						sub include_test content
						sub comsize include_test
						add content include_test
						SetCall errormsg quotinmem(pcontent,pcomsize,pquotsz,pescapes)
						if errormsg=noerr
							SetCall errormsg xfile_add_base_ifif((Xfile_include_alternative_yes),content,quotsz)
						endif
					else
						setcall errormsg xfile_add_char_ifif((Xfile_include_alternative_no))
					endelse
				endif
			endif
			if errormsg=noerr
				SetCall errormsg addtosecstresc(pcontent,pcomsize,quotsz,escapes,ptrmiscbag,zero)
				If errormsg=noerr
					Call stepcursors(pcontent,pcomsize)
					Set includebool one
					if include_sec=(FALSE)
						SetCall errormsg include_sec_skip(pcontent,pcomsize)
					endif
				EndIf
			endif
		endif
	EndIf
endif
