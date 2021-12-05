
Data argumentssize#1

if argc<1
	Chars cmdscripterr="Cannot parse to input file name."
	Str ptrcmdscripterr^cmdscripterr
	Call msgerrexit(ptrcmdscripterr)
endif

setcall argumentssize strlen(argv0)

#if the file was executed from the PATH, then the root folder it is searched
str scriptfullname#1
set scriptfullname null
chars slash=asciislash
data accessresult#1
data slashtest#1

set accessresult negative
setcall slashtest valinmem(argv0,argumentssize,slash)
if slashtest!=argumentssize
	set scriptfullname argv0
else
	str envpath#1
	str pathstr="PATH"
	setcall envpath getenv(pathstr)
	if envpath==null
		str enverr="Getenv error on PATH."
		call Message(enverr)
	endif
	data sizeofpath#1
	setcall sizeofpath strlen(envpath)
	while sizeofpath!=zero
		chars pathdelim=":"
		data sizeoffolder#1
		setcall sizeoffolder valinmem(envpath,sizeofpath,pathdelim)

		data sizetocreate#1
		set sizetocreate sizeoffolder
		#this one is if '/' needs to be added after the folder
		inc sizetocreate
		add sizetocreate argumentssize
		inc sizetocreate
		setcall scriptfullname memalloc(sizetocreate)
		if scriptfullname==null
			set sizeofpath zero
		else
			#do not work on null PATH parts
			if sizeoffolder!=null
				str scrpointer#1
				set scrpointer scriptfullname
				call memtomem(scrpointer,envpath,sizeoffolder)
				add scrpointer sizeoffolder
				dec scrpointer

				chars slashcompare#1
				set slashcompare scrpointer#
				inc scrpointer
				if slashcompare!=slash
					set scrpointer# slash
					inc scrpointer
				endif
				call memtomem(scrpointer,argv0,argumentssize)
				add scrpointer argumentssize
				set scrpointer# null

				data runaccess=X_OK
				setcall accessresult access(scriptfullname,runaccess)
			endif
			if accessresult==zero
				#continue with this path to preferences
				set sizeofpath zero
			else
				call free(scriptfullname)
				set scriptfullname null
				add envpath sizeoffolder
				sub sizeofpath sizeoffolder
				if envpath#==pathdelim
					inc envpath
					dec sizeofpath
				endif
			endelse
		endelse
	endwhile
endelse

if scriptfullname==null
	str patherr="Pathfind error."
	call Message(patherr)
else
	call setpreferences(scriptfullname)
	if scriptfullname!=argv0
		call free(scriptfullname)
	endif
endelse

if argc<2
	Chars cmdnoinput="O Compiler - usage: o \"filename\" [conv_64]"
	chars moreinfo="Documentation is here: https://htmlpreview.github.io/?https://github.com/colin-i/o/blob/master/o.html"
	ss moreinfo_helper^moreinfo
	dec moreinfo_helper;set moreinfo_helper# (asciireturn)
	Call msgerrexit(#cmdnoinput)
EndIf

set path_nofree argv1
