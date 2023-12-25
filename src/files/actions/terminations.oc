

#verify that all conditions are closed
SetCall errormsg checkcondloopclose()
If errormsg!=noerr
	Call msgerrexit(errormsg)
EndIf

#verify preferences
sd err_bool
setCall err_bool warnings(#errormsg,el_or_e)
If errormsg!=noerr
	if err_bool=(TRUE)
		Call msgerrexit(errormsg)
	endif
	call errexit()
EndIf

#last entry for log file
setcall errormsg addtolog_natural(datasecReg)
if errormsg!=(noerror)
	call msgerrexit(errormsg)
endif
