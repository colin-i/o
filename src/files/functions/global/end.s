
#err
function endfunction(sd parses)
	if parses=(pass_init)
		if main.innerfunction=(FALSE)
			Char unexef="Unexpected ENDFUNCTION command."
			Str unexeferr^unexef
			return unexeferr
		else
			Set main.innerfunction (FALSE)
			call vars_log_reset() #to let next variables be ".var"
		endelse
	elseif parses=(pass_write)
		sd err
		setcall err xfile_add_end_if()
		if err=(noerror)
			setCall err checkcondloopclose()
			If err=(noerror)
				data ptrreturn#1
				data sizereturn#1
				data ptrptrreturn^ptrreturn
				setcall sizereturn getreturn(ptrptrreturn)
				SetCall err addtoCode_set_programentrypoint(ptrreturn,sizereturn)
				If err=(noerror)
					setcall err scopes_store(main.functionTagIndex)
					If err=(noerror)
						sd i
						Set i 0
						While i!=(numberofvars)
						#here is clearing indexes to not call variables from this scope in the parent scope
							Data containertoclear#1
							SetCall containertoclear getstructcont(i)
							Data indexptr#1
							Data ptrindexptr^indexptr
							Call getptrcontReg(containertoclear,ptrindexptr)
							Set indexptr# 0
							Inc i
						EndWhile
					else
						return err
					endelse
				else
					return err
				endelse
			else
				return err
			endelse
			Set main.innerfunction (FALSE)
		else
			return err
		endelse
	endelseif
	inc main.functionTagIndex
	return (noerror)
endfunction
