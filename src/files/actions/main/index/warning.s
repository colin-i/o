
setcall errormsg xfile_add_char_ifif((Xfile_orphan))
if errormsg=(noerror)
	Data warningsboolptr%ptrwarningsbool
	sd warning_bool
	setcall warning_bool stratmem(pcontent,pcomsize,"ON")
	if warning_bool=(TRUE)
		set warningsboolptr# (TRUE)
		setcall errormsg xfile_add_char_ifif((Xfile_orphan_yes))
	else
		setcall warning_bool stratmem(pcontent,pcomsize,"OFF")
		if warning_bool=(TRUE)
			set warningsboolptr# (FALSE)
			setcall errormsg xfile_add_char_ifif((Xfile_orphan_no))
		else
			set errormsg "Expecting 'on' or 'off' command"
		endelse
	endelse
endif
