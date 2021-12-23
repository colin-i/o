
#inits needed on top then some allocs at openfilename then frees needing inits, then these allocs
Include "./inits/alloc.s"

if includedir==(TRUE)
	set fileendchar (log_fileend)
else
	set fileendchar (log_fileend_old)
endelse

Include "./actions/setdefdir.s"

SetCall errormsg include(safecurrentdirtopath)
If errormsg!=noerr
	Call msgerrexit(errormsg)
EndIf

Include "./actions/main.s"

Include "./actions/terminations.s"

Include "./actions/pathout.s"

Include "./actions/fileformat.s"

#call to resolve local or imported functions
Include "./actions/resolve.s"

Include "./actions/write.s"

Call freeclose()