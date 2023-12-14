
#inits needed on top then some allocs at openfilename then frees needing inits, then these allocs
SetCall errormsg enumbags(true)
#here is the start of mem worries for linux
If errormsg!=noerr
	Call msgerrexit(errormsg)
EndIf

Include "./actions/setdefdir.s"

Set includebool zero ##include or not include for applying after command parse
SetCall errormsg include(safecurrentdirtopath,(TRUE),(cINCLUDE))
If errormsg!=noerr
	Call msgerrexit(errormsg)
EndIf

include "./inits/inits.s"

Include "./actions/main.s"

Include "./actions/terminations.s"

if xbool!=(Yes_strict)
	#close the last LIBRARY
	If fileformat=pe_exec
		If implibsstarted=true
			SetCall errormsg closelib()
			If errormsg!=noerr
				Call msgerrexit(errormsg)
			EndIf
		EndIf
	EndIf
	Include "./actions/pathout.s"
	Include "./actions/fileformat.s"
	Include "./actions/resolve.s" #call to resolve local or imported functions
	Include "./actions/write.s"
endif

Call freeclose()
