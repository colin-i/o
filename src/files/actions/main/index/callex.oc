
setcall errormsg xfile_add_callret_if((Xfile_callex),subtype)
if errormsg=(noerror)
	sd call_sz
	call arg_size(pcontent#,pcomsize#,#call_sz)
	sd top_data
	sd bool_indirect
	setcall errormsg prepare_function_call(pcontent,pcomsize,call_sz,#top_data,#bool_indirect,subtype)
	if errormsg=(noerror)
		call spaces(pcontent,pcomsize)
		setcall errormsg twoargs(pcontent,pcomsize,(cCALLEX_primsec),(NULL))
		if errormsg=(noerror)
			#
			sd callex_data;sd callex_sz
			const callex_regopcode=ecxregnumber*toregopcode
			sd callex_bool;setcall callex_bool is_for_64()
			if callex_bool=(TRUE)
				sd callex64;setcall callex64 is_for_64_is_impX_or_fnX_get()
				if callex64=(TRUE)
					setcall errormsg callex64_call()
				endif
				if errormsg=(noerror)
					const callex_x86_64_start=\
					#same but with 2 rex, inc je, -2 jmp, and 3* at sib
					char callex_x86_64={REX_Operand_64,0x81,0xf9,0,0,0,0,0x74,8,REX_Operand_64,0xFF,1*toregopcode|ecxregnumber|regregmod,0xff,6*toregopcode|espregnumber,3*tomod|callex_regopcode,0xEB,0xef}
					set callex_sz (\-callex_x86_64_start);set callex_data #callex_x86_64
				endif
			else
				const callex_start=\
				# ## cmp ecx,0
				char callex_i386={0x81,0xf9};data *=0
				#je ###
				char *={0x74};char *callex_je=7
				#dec ecx
				char *=0xFF;char *=1*toregopcode|ecxregnumber|0xc0
				# push [eax+ecx*4]
				char *callex_c2=0xff;char *=6*toregopcode|espregnumber;char *callex_sib=2*tomod|callex_regopcode
				#jmp ##
				char *=0xEB;char *callex_jmp=0xf1
				#
				set callex_sz (\-callex_start);set callex_data #callex_i386
			endelse
			#
			if errormsg=(noerror)
				SetCall errormsg addtosec(callex_data,callex_sz,ptrcodesec)
				if errormsg=(noerror)
					setcall errormsg write_function_call(top_data,bool_indirect,(TRUE),subtype)
					if errormsg=(noerror)
						setcall errormsg after_after_call(subtype)
					endif
				endif
			endif
		endif
	endif
endif
