

Char safedirdata="./"
Str safedir^safedirdata

Str filenameloc#1
SetCall filenameloc endoffolders(path_nofree)
Char storeachar#1
Set storeachar filenameloc#
Set filenameloc# null

sd chdirresult#1
setcall chdirresult changedir(path_nofree)
if chdirresult!=chdirok
	str startchdirerr="Cannot set active folder:"
	setcall errormsg errorDefOut(startchdirerr,path_nofree)
	Call msgerrexit(errormsg)
endif


Set filenameloc# storeachar

Data movesize#1
SetCall movesize strlen(filenameloc)
Inc movesize

setcall errormsg maxpathverif(filenameloc,safedir)
if errormsg!=noerr
	Call msgerrexit(errormsg)
endif

SetCall safecurrentdirtopath memalloc(flag_max_path)
If safecurrentdirtopath=null
	Call errexit()
EndIf

#files
Set fileout (openno)
set logfile (openno)
set xfile (openno)

#scopes and pass_calls
set stackalign (NULL)
set scopesbag (NULL)

Call memtomem(safecurrentdirtopath,safedir,wordsize)
Data safecurrentdirloc#1
Set safecurrentdirloc safecurrentdirtopath
Add safecurrentdirloc wordsize
Call memtomem(safecurrentdirloc,filenameloc,movesize)

if logbool=true
	setcall errormsg openfile_write_add_extension(safecurrentdirtopath,".log",ptrlogfile)
	if errormsg=noerr
		sd log_main_folder
		setcall log_main_folder getcwd((NULL),0)
		if log_main_folder=(NULL)
			char getcwd_first="first getcwd error"
			set errormsg #getcwd_first
		else
			setcall errormsg addtolog_withchar_parses(log_main_folder,(log_pathfolder),(TRUE))
			call free(log_main_folder)
		endelse
	endif
endif
if xbool=true
	setcall errormsg openfile_mode_add_extension(safecurrentdirtopath,".x",#xfile,(_open_readwrite))
endif
if errormsg!=noerr
	Call msgerrexit(errormsg)
endif
