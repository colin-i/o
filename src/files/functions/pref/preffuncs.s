

function constants_bool(sd direction)
	data bool#1
	if direction==(const_warn_get)
		return bool
	endif
	return #bool
endfunction

function logincludes_decision(ss str)
	sd b;setcall b logincludes_bool()
	if b#==(TRUE)
		call addtolog(str)
	endif
endfunction
function logincludes_bool()
	data bool#1
	return #bool
endfunction

#void
Function warnings(sd searchInAll,sd includes,sd nameoffset,sd p_err)
	Data warningsboolptr%ptrwarningsbool
	Data warningsbool#1
	Data null=NULL
	Data true=TRUE
	Data false=FALSE

	Set warningsbool warningsboolptr#
	If warningsbool==false
		Return null
	EndIf

	Data var#1

	SetCall var searchinvars(null,null,null,p_err)
	If var==null
		If searchInAll==true
			data ptrcodeFnObj%ptrcodeFnObj
			if ptrcodeFnObj#!=(ignore_warn)
				Data functionsptr%ptrfunctions
				SetCall var varscore(null,null,functionsptr,p_err)
			endif
			if var==null
				sd cb;setcall cb constants_bool((const_warn_get))
				if cb!=(ignore_warn)
					data constantsptr%ptrconstants
					SetCall var varscore(null,null,constantsptr,p_err)
				endif
			endif
		EndIf
	EndIf
	If var!=null
		Chars unrefformat="Unreferenced variable/function/constant: %s. Scope Termination File: %s. To disable this warning see '.ocompiler.txt'"
		Str ptrunrefformat^unrefformat

		Data printbuffer#1

		Data fileoff=nameoffset
		Add var fileoff
		Add includes nameoffset
		SetCall printbuffer printbuf(ptrunrefformat,var,includes,0)
		If printbuffer!=null
			sd pallocerrormsg%ptrallocerrormsg
			set pallocerrormsg# printbuffer
		EndIf
		Call safeMessage(printbuffer)
	EndIf
EndFunction

#void
#parse and set the value, 0-9(one digit) values are expected here
function parsepreferences(data ptrcontent,data ptrsize,data ptrvalue)
	Chars searchsign="="
	Data sizeuntilsign#1

	str content#1
	data size#1
	set content ptrcontent#
	set size ptrsize#

	SetCall sizeuntilsign valinmem(content,size,searchsign)
	call advancecursors(ptrcontent,ptrsize,sizeuntilsign)

	If sizeuntilsign!=size
		Call stepcursors(ptrcontent,ptrsize)
		set content ptrcontent#
		set size ptrsize#
		data zero=0
		If size!=zero
			Call stepcursors(ptrcontent,ptrsize)
			Set ptrvalue# content#
			data asciiNumbersStart=asciizero
			Sub ptrvalue# asciiNumbersStart
		EndIf
	EndIf

	data false=FALSE
	return false
endfunction

#void
function setpreferences(str scrpath)
	#defaults
	data ptrwarningsbool%ptrwarningsbool
	data ptrlogbool%ptrlogbool
	data ptrincludedir%ptrincludedir
	data ptrcodeFnObj%ptrcodeFnObj
	data ptr_log_import_functions%ptr_log_import_functions

	data true=TRUE
	data false=FALSE
	data defaultcodeFnObj=log_warn

	set ptrwarningsbool# true
	set ptrlogbool# false
	set ptrincludedir# true
	set ptrcodeFnObj# defaultcodeFnObj
	sd text_fn_info
	setcall text_fn_info fn_text_info()
	set text_fn_info# false
	set ptr_log_import_functions# true
	sd neg_64
	setcall neg_64 p_neg_is_for_64()
	set neg_64# false
	sd sdsv_p
	setcall sdsv_p sd_as_sv((sd_as_sv_get))
	set sdsv_p# false
	sd cb;setcall cb constants_bool((const_warn_get_init))
	set cb# (FALSE)
	sd li;setcall li logincludes_bool()
	set li# (TRUE)


	Str preferences=".ocompiler.txt"
	data err#1
	data noerr=noerror
	Str preferencescontent#1
	Data ptrpreferencescontent^preferencescontent
	Data preferencessize#1
	Data ptrpreferencessize^preferencessize

	setcall err prefextra(preferences,ptrpreferencessize,ptrpreferencescontent)
	If err!=noerr
		Call safeMessage(err)

		data null=0
		data void#1

		str folders#1
		setcall folders endoffolders(scrpath)
		set folders# null
		sub folders scrpath

		data prefsz#1
		setcall prefsz strlen(preferences)
		inc prefsz

		data total#1
		set total folders
		add total prefsz

		data ptrmem#1
		data allocptrmem^ptrmem
		setcall err memoryalloc(total,allocptrmem)
		if err!=noerr
			call Message(err)
			return void
		endif

		call memtomem(ptrmem,scrpath,folders)

		str apppath#1
		set apppath ptrmem
		add apppath folders
		call memtomem(apppath,preferences,prefsz)

		SetCall err file_get_content_ofs(ptrmem,ptrpreferencessize,ptrpreferencescontent,null)
		call free(ptrmem)
		If err!=noerr
			Call safeMessage(err)
		EndIf
	endif
	If err==noerr
		Data freepreferences#1
		Set freepreferences preferencescontent

		call parsepreferences(ptrpreferencescontent,ptrpreferencessize,ptrwarningsbool)
		call parsepreferences(ptrpreferencescontent,ptrpreferencessize,ptrlogbool)
		call parsepreferences(ptrpreferencescontent,ptrpreferencessize,ptrincludedir)
		call parsepreferences(ptrpreferencescontent,ptrpreferencessize,ptrcodeFnObj)
		call parsepreferences(ptrpreferencescontent,ptrpreferencessize,text_fn_info)
		call parsepreferences(ptrpreferencescontent,ptrpreferencessize,ptr_log_import_functions)
		call parsepreferences(ptrpreferencescontent,ptrpreferencessize,neg_64)
		call parsepreferences(ptrpreferencescontent,ptrpreferencessize,sdsv_p)
		call parsepreferences(ptrpreferencescontent,ptrpreferencessize,cb)
		call parsepreferences(ptrpreferencescontent,ptrpreferencessize,li)

		Call free(freepreferences)
	endif
EndFunction
#void
