
setcall errormsg xfile_add_char_if((Xfile_hex))
if errormsg=(noerror)
	setcall errormsg enumcommas(pcontent,pcomsize,pcomsize#,(fndecandgroup),(charnumber),(NULL),(hexenum)) #there are 4 more arguments but are not used
	if errormsg=(noerror)
		setcall errormsg xfile_add_commas_if()
	endif
endif
