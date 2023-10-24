

#bool numeric
Function numeric(char c)
	Char zero={asciizero}
	Char nine={asciinine}
	Data false=FALSE
	Data true=TRUE
	If c<zero
		Return false
	ElseIf c>nine
		Return false
	EndElseIf
	Return true
EndFunction

#bool
Function memtoint(str content,data size,data outvalue,data minusbool)
	#if size==0 not required in the program, it already comes at least 1

	Data value#1
	Data number#1

	data multx#1
	Set value 0
	set multx 1

	Add content size
	While size!=0
		Dec content;Dec size

		Data bool#1
		Char byte#1
		Set byte content#
		SetCall bool numeric(byte)
		If bool==(FALSE)
			Return (FALSE)
		EndIf
		Sub byte (asciizero)
		Set number byte

		const bil_1=1000*1000*1000
		const bil_2=2*bil_1
		const max_int=0x80*0x100*0x100*0x100
		const max_int_bil_2_rest=max_int-bil_2
		if multx==(bil_1)
			if size!=0
				#(...)x xxx xxx xxx
				while size!=0
					Dec content;Dec size
					if content#!=(asciizero)
						return (FALSE)
					endif
				endwhile
			endif
			if number>2
				#3 xxx xxx xxx-9 xxx xxx xxx
				return (FALSE)
			elseif number==2
				if value>(max_int_bil_2_rest)
					#2 147 483 649-2 999 999 999
					return (FALSE)
				elseif value==(max_int_bil_2_rest)
					if minusbool==(FALSE)
						#2 147 483 648 is the first positive overflow
						return (FALSE)
					endif
				endelseif
			endelseif
		endif

		mult number multx;mult multx 10
		Add value number
	EndWhile
	Set outvalue# value
	Return (TRUE)
EndFunction

const nothex_value=-1

#out -1 or the converted number
Function hexnr(char byte)
	Char Asciizero={asciizero}
	Char Asciinine={asciinine}
	Char AsciiA={asciiA}
	Char AsciiF={asciiF}
	Char Asciia={asciia}
	Char Asciif={asciif}
	Char afternine={10}
	If byte<Asciizero
		Return (nothex_value)
	ElseIf byte<=Asciinine
		Sub byte Asciizero
	ElseIf byte<AsciiA
		Return (nothex_value)
	ElseIf byte<=AsciiF
		Sub byte AsciiA
		Add byte afternine
	ElseIf byte<Asciia
		Return (nothex_value)
	ElseIf byte<=Asciif
		Sub byte Asciia
		Add byte afternine
	Else
		Return (nothex_value)
	EndElse
	Return byte
EndFunction

#bool
Function memtohex(str content,data size,data outvalue)
	Data initialval=0
	Data initiallimit=3
	Data val#1
	Data limit#1
	Data false=FALSE
	Data true=TRUE
	Data seven=7

	Set val initialval
	Set limit initiallimit

	If size<limit
		Return false
	EndIf
	Add limit seven
	If limit<size
		Return false
	EndIf

	Str pc^content
	Data ps^size
	Data bool=0
	Data zero=0
	Char byte#1
	Data nr#1
	Data initialmultp=1
	Data multp#1

	Set multp initialmultp
	SetCall bool stratmem(pc,ps,"0X")
	If bool==false
		Return false
	EndIf
	Add content size
	While size!=zero
		Dec content
		Dec size
		Set byte content#
		SetCall nr hexnr(byte)
		If nr==(nothex_value)
			Return false
		EndIf
		Mult nr multp
		Add val nr
		Data hextimes=16
		Mult multp hextimes
	EndWhile
	Set outvalue# val
	Return true
EndFunction

#error
function numbertoint(vstrx content,datax size,datax outval,datax minusbool)
	Data bool#1
	#test to see if the ! sign is present
	if content#==(asciiexclamationmark)
		sd err

		if size==1
			#the current data cursor
			setcall outval# get_img_vdata_dataReg()

			setcall err xfile_add_char_ifif((Xfile_numbers_type_idata))
			return err
		endif

		vdata p_parses%ptr_parses
		inc content
		charx against#1
		set against content#
		if against==(asciiexclamationmark)
			if size==2
				#the current virtual data cursor
				#main.ptr_nobits_virtual not yet at ocompiler, we have WinMain/main or (NULL)
				vdata ptr_nobits_virtual%ptr_nobits_virtual
				if ptr_nobits_virtual#==(No)
					if p_parses#==(pass_init)
						return "At the moment, !! is not implemented here."
					endif
				endif
				setcall outval# get_img_vdata_dataSize()

				setcall err xfile_add_char_ifif((Xfile_numbers_type_idatax))
				return err
			endif
			inc content
			sub size 2

			if p_parses#==(pass_init)
				return "At the moment, !!func is not implemented here."  #after pass_init is the calloc for scopes
			endif
			setcall err xfile_add_char_if((Xfile_numbers_type_sizeXFunc))  #getarg_base can write for xfile
			if err==(noerror)
				setcall err get_sizeoffunction(content,size,outval,(TRUE))
			endif
			return err
		endif

		dec size
		sd dot_offset;setcall dot_offset valinmem(content,size,(asciidot))
		if dot_offset!=size
			if p_parses#==(pass_init)
				return "At the moment, !a.b or !a.b! are not implemented here."  #after pass_init is the calloc for scopes
			endif
			#suffixed,casted, nobody is stopping them (casted will not reach here, will be xor)
			#	and suffix+0 at def, else is a comment;at code is ok
			ss pointer=-1;add pointer content;add pointer size
			datax data#1;datax low#1;datax sufix#1
			if pointer#!=(asciiexclamationmark)
				#size of variable
				setcall err xfile_add_char_if((Xfile_numbers_type_sizeVar))
				if err==(noerror)
					setcall err getarg_dot_any(content,size,dot_offset,#data,#low,#sufix)
					if err==(noerror)
						if low!=0
							set outval# (bsz)
						else
							set outval# (dwsz)
							sd test;setcall test stackbit(data)
							if test==0
								if sufix==0
									setcall test datapointbit(data)
									if test!=0
										set outval# (qwsz)
									endif
								else
									setcall test pointbit(data) #it has 64 check
									if test!=0
										set outval# (qwsz)
									endif
								endelse
							else
								if sufix==0
									setcall outval# stack64_enlarge(outval#)
								else
									setcall test pointbit(data) #it has 64 check
									if test!=0
										set outval# (qwsz)
									endif
								endelse
							endelse
						endelse

						if sufix==0
							add data (maskoffset_reserve)
							sd shortvalue;setcall shortvalue s_to_i(data)
							if shortvalue==0
								return "Great reserve size is not implemented yet."
							endif
							mult outval# shortvalue
						endif
					endif
				endif
			else
				# !a.b! offset
				dec size

				setcall err xfile_add_char_if((Xfile_numbers_type_offsetVar))  #getarg_base can write for xfile
				if err==(noerror)
					setcall err getarg_base(content,size,dot_offset,#data,#low,#sufix,outval)
					if err==(noerror)
						if sufix!=0
							return "Not using offset of suffix."
						endif
						sub outval# data#
						neg outval#
					endif
				endif
			endelse
		else
			if p_parses#==(pass_init)
				return "At the moment, !func is not implemented here."  #after pass_init is the calloc for scopes
			endif
			setcall err xfile_add_char_if((Xfile_numbers_type_sizeFunc))  #getarg_base can write for xfile
			if err==(noerror)
				setcall err get_sizeoffunction(content,size,outval,(FALSE))
			endif
		endelse
		return err
	#test for : sign (the size of a stack value, 4B on 32-bits, 8B on 64-bits)
	char int_size=asciicolon
	elseif content#==int_size
		if size!=1;return "The text after the size of an integer sign isn't recognized.";endif
		sd b;setcall b is_for_64()
		if b==(FALSE);set outval# (dwsz)
		else;set outval# (qwsz);endelse

		setcall err xfile_add_char_ifif((Xfile_numbers_type_ilong))
		return err
	endelseif
	#decimal or hex number
	SetCall bool memtoint(content,size,outval,minusbool)
	If bool==0
		SetCall bool memtohex(content,size,outval)
		If bool==0
			Char _intvalerr="Integer(dec/hex) value not recognized."
			Str intvallerr^_intvalerr
			Return intvallerr
		Else
			setcall err xfile_add_base_ifif((Xfile_numbers_type_thex),content,size)
		EndElse
	Else
		setcall err xfile_add_base_ifif((Xfile_numbers_type_tdecimal),content,size)
	EndElse
	return err
endfunction

#size of function
function get_sizeoffunction(sd content,sd size,sd outval,sd is_expand)
	sd err
	sd pos
	setcall err get_scope_pos(content,size,#pos)
	if err==(noerror)
		setcall outval# get_scope_data_size(pos,is_expand)
	endif
	return err
endfunction

#err pointer
Function numbersconstants(str content,data size,data outval)
	Str intconsterr="Integer(dec/hex) or constant value expected."
	If size==0
		Return intconsterr
	EndIf

	sd xprefixes=Xfile_numbers_prefix_none

	char not=not_number
	sd notbool=FALSE
	if content#==not
		set notbool (TRUE)
		inc content
		dec size
		If size==0
			Return intconsterr
		EndIf
		or xprefixes (Xfile_numbers_prefix_not)
	endif
	sd minusbool=FALSE
	if content#==(asciiminus)
		set minusbool (TRUE)
		inc content
		dec size
		If size==0
			Return intconsterr
		EndIf
		or xprefixes (Xfile_numbers_prefix_neg)
	endif

	sd err
	setcall err xfile_add_char_ifif(xprefixes)
	if err==(noerror)
		sd bool
		setcall bool is_variable_char_not_numeric(content#)
		If bool==(FALSE)
			setcall err numbertoint(content,size,outval,minusbool)
		Else
			Data constr%%ptr_constants
			Data pointer#1
			SetCall pointer vars(content,size,constr)
			If pointer==0
				Char unconst="Undefined constant name."
				Str ptruncost^unconst
				Return ptruncost
			EndIf
			Set outval# pointer#

			setcall err xfile_add_base_ifif((Xfile_numbers_type_tconstant),content,size)
		EndElse
		if err==(noerror)
			if notbool==(TRUE)
				not outval#
			endif
			if minusbool==(TRUE)
				mult outval# -1
			endif
		endif
	endif
	return err
EndFunction

#er
function parenthesis_size(ss content,sd size,sd ptr_sz)
	sd opens=1
	data z=0
	sd mark
	data noerr=noerror
	sd last
	Char closefnexp="Close parenthesis sign (')') expected."
	Str closeerr^closefnexp

	set mark content
	set last content
	add last size
	while content!=last
		if content#==(asciidoublequote)
			sd er
			setcall er quotes_forward(#content,last,0)
			if er!=(noerror)
				return er
			endif
		endif
		if content==last
			return closeerr
		endif
		Char fnbegin=asciiparenthesisstart
		Char fnend=asciiparenthesisend
		if content#==fnend
			dec opens
			if opens==z
				sub content mark
				set ptr_sz# content
				return noerr
			endif
		elseif content#==fnbegin
			inc opens
		endelseif
		inc content
	endwhile
	Return closeerr
endfunction

#len
function dwtomem(sd dw,ss mem)
	sd len
	setcall len sprintf(mem,"%u",dw)
	return len
endfunction
