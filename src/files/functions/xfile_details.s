
#err
function xfile_add_declare(ss content,sd size)
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
		setcall err xfile_add_string_if(content,size)
	endif
	return err
endfunction
