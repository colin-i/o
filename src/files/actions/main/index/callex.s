

sd call_sz
setcall errormsg arg_size(pcontent#,pcomsize#,#call_sz)
if errormsg==(noerror)
	sd top_data
	sd bool_indirect
	setcall errormsg prepare_function_call(pcontent,pcomsize,call_sz,#top_data,#bool_indirect)
	if errormsg==(noerror)
		call spaces(pcontent,pcomsize)
		setcall errormsg twoargs(pcontent,pcomsize,(cCALLEX),(NULL))
		if errormsg==(noerror)
			#
			sd callex64;setcall callex64 is_for_64_is_impX_or_fnX_get()
			if callex64==(TRUE)
				setcall errormsg callex64_call()
			endif
			#
			if errormsg==(noerror)
				const callex_start=!
				# ## cmp ecx,0
				chars callex_c1={0x81,0xf9};data *=0
				#je ###
				chars *={0x74};chars *callex_je=7
				#dec ecx
				chars *=0xFF;chars *=1*toregopcode|ecxregnumber|0xc0
				#const callex_size1=!-callex_start
				# push [eax+ecx*4]  this is gdb view
				chars *callex_c2=0xff;chars *=6*toregopcode|espregnumber;chars callex_sib#1
				#jmp ##
				chars *=0xEB;chars *callex_jmp=0xf1
				# ###
				const callex_size=!-callex_start
				#
				#set mov.sib: index ecx and base eax
				set callex_sib (ecxregnumber*toregopcode)
				sd callex_bool;setcall callex_bool is_for_64()
				if callex_bool==(FALSE);or callex_sib (2*tomod)
				else;#for 64
					or callex_sib (3*tomod)
				endelse
				#
				SetCall errormsg addtosec(#callex_c1,(callex_size),ptrcodesec)
				if errormsg==(noerror)
					setcall errormsg write_function_call(top_data,bool_indirect,(TRUE))
				endif
			endif
		endif
	endif
endif
