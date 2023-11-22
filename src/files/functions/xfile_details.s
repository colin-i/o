
#err
function xfile_add_declare_if(sd decltype,sd is_stack,sd is_expand,ss content,sd size,sd sign,sd reloc,sd relocx)
	if main.xfile!=(openno)
		sd err
		if decltype=(Xfile_decltype_const)
			setcall err xfile_add_char((Xfile_declfield_const))
		else
			if is_stack=(TRUE)
				setcall err xfile_add_char((Xfile_declfield_stack))
			else
				setcall err xfile_add_char((Xfile_declfield_data))
				if err=(noerror)
					if is_expand=(TRUE)
						setcall err xfile_add_char((Xfile_declfield_data_expand))
					else
						setcall err xfile_add_char((Xfile_declfield_data_concrete))
					endelse
				endif
			endelse
			if err=(noerror)
				setcall err xfile_add_char(decltype)
				if err=(noerror)
					if content#=(throwlesssign)
						setcall err xfile_add_char((Xfile_declfeature_throwless))
						call stepcursors(#content,#size)
					elseif content#=(unrefsign)
						setcall err xfile_add_char((Xfile_declfeature_unref))
						call stepcursors(#content,#size)
					else
						setcall err xfile_add_char((Xfile_declfeature_normal))
					endelse
				endif
			endif
		endelse
		if err=(noerror)
			setcall err xfile_add_string(content,size)
			if sign!=(sign_not_required)
				if err=(noerror)
					if sign=(assignsign)
						if reloc=(FALSE)
							setcall err xfile_add_char((Xfile_declsign_equal))
						elseif relocx=(FALSE)
							setcall err xfile_add_char((Xfile_declsign_reloc))
						else
							setcall err xfile_add_char((Xfile_declsign_relocx))
						endelse
					elseif sign=(reservesign)
						setcall err xfile_add_char((Xfile_declsign_reserve))
					elseif sign=(pointersigndeclare)
						setcall err xfile_add_char((Xfile_declsign_pointer))
					else
					#if sign==(nosign) reserve
						setcall err xfile_add_char((Xfile_declsign_reserve))
					endelse
				endif
			endif
		endif
		return err
	endif
	return (noerror)
endfunction

#err
function xfile_add_fndef_if(sd content,sd sz,sd fn,sd x_or_not_x,sd varargs)
	if main.xfile!=(openno)
		sd err
		setcall err xfile_add_base((Xfile_functiondef),content,sz)
		if err=(noerror)
			setcall err xfile_add_char(fn)
			if err=(noerror)
				if x_or_not_x!=(Xfile_function_not_x)
					if varargs=0
						setcall err xfile_add_char((Xfile_function_e_normal))
					else
						setcall err xfile_add_char((Xfile_function_e_varargs))
					endelse
				endif
			endif
		endif
		return err
	endif
	return (noerror)
endfunction

#err
function xfile_add_varsufix_if(sd content,sd size,sd sufix,sd cast)
	if main.xfile!=(openno)
		sd err;setcall err xfile_add_string(content,size)
		if err=(noerror)
			setcall err xfile_add_char(sufix)
			if sufix=(Xfile_suffix_true)
				if err=(noerror)
					setcall err xfile_add_char(cast)
				endif
			endif
		endif
		return err
	endif
	return (noerror)
endfunction

data xf_commas#1;data xf_pos#1
#err
function xfile_prepare_commas_if()
	if main.xfile!=(openno)
		sd err
		setcall main.xf_pos seekfile(main.xfile,0,(SEEK_CUR),#err)
		if main.xf_pos=-1
			return err
		endif
		set main.xf_commas 0
	endif
	return (noerror)
endfunction
function xfile_inc_commas_if()
	if main.xfile!=(openno)
		inc main.xf_commas
	endif
endfunction
#err
function xfile_add_commas_if()
	if main.xfile!=(openno)
		sd err
		sd off;setcall off seekfile(main.xfile,0,(SEEK_CUR),#err)
		if off=-1;return err;endif
		sub off main.xf_pos
		sd mem
		setcall err mem_alloc(off,#mem)
		if err=(noerror)
			sd sz
			setcall sz seekfile(main.xfile,main.xf_pos,(SEEK_SET),#err)
			if sz!=-1
				setcall err readfile(main.xfile,mem,off)
				if err=(noerror)
					setcall sz seekfile(main.xfile,main.xf_pos,(SEEK_SET),#err)
					if sz!=-1
						call lseek(main.xfile,0,(SEEK_CUR))
						setcall err xfile_add_int(main.xf_commas)
						if err=(noerror)
							call lseek(main.xfile,0,(SEEK_CUR))
							setcall err writefile_errversion(main.xfile,mem,off)
							call lseek(main.xfile,0,(SEEK_CUR))
						endif
					endif
				endif
			endif
			call free(mem)
		endif
		return err
	endif
	return (noerror)
endfunction
#err
function xfile_add_commas_interncall_if(sd content,sd size,sd sz)
	if main.xfile!=(openno)
		sd p;setcall p nr_of_args_64need_p_get();set p# 0
		sd err
		SetCall err enumcommas(#content,#size,sz,(FALSE),(pass_calls)) #there are 6 more arguments but are not used
		if err=(noerror)
			setcall err xfile_add_int(p#)
		endif
		return err
	endif
	return (noerror)
endfunction

#err
function xfile_add_call_if(sd content,sd size,sd subtype)
	if main.xfile!=(openno)
		sd err
		setcall subtype callx_flag(subtype)  #this is tested if 64 in the normal place
		if subtype=0
			setcall err xfile_add_char((Xfile_arg_call_normal)) #not forced extern
		else
			setcall err xfile_add_char((Xfile_arg_call_extern)) #forced extern
		endelse
		if err=(noerror)
			setcall err xfile_add_string(content,size)
		endif
		return err
	endif
	return (noerror)
endfunction
#err
function xfile_add_callret(sd action,sd subtype)
	sd err

	setcall err xfile_add_char(action)
	if err=(noerror)
		#this can go also with primsec with a test against CALL_primsec, add that flag at getcommand, but still there is a wrong cosmetic at subtype_test=0 and not subtype_test=CALL_primsec in a case
		setcall subtype callret_flag(subtype)
		if subtype=0
			setcall err xfile_add_char((Xfile_call_normal))
		else
			setcall err xfile_add_char((Xfile_call_ret))
		endelse
	endif

	return err
endfunction
#err
function xfile_add_callret_if(sd action,sd subtype)
	if main.xfile!=(openno)
		sd err
		setcall err xfile_add_callret(action,subtype)
		return err
	endif
	return (noerror)
endfunction
#err
function xfile_add_callret_ifif(sd action,sd subtype)
	if main.parses=(pass_write)
		sd err
		setcall err xfile_add_callret_if(action,subtype)
		return err
	endif
	return (noerror)
endfunction

#err
function xfile_add_end_if()
	sd err;setcall err xfile_add_char_if((Xfile_condend));return err
endfunction
#err
function xfile_add_end_ifif()
	if main.parses=(pass_write)
		sd err;setcall err xfile_add_end_if();return err
	endif
	return (noerror)
endfunction
