
if g_e_b_p#==(FALSE)
	set errormsg "AfterCall is not defined."
else
	sd acall_val
	if subtype==(cAFTERCALLACTIVATE)
		set acall_val (~aftercall_clearstate)
	else
	#cAFTERCALLCLEAR
		set acall_val (aftercall_clearstate)
	endelse

	#REX + C6 /0 ib
endelse
