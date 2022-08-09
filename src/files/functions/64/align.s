
#er
function stack_align(sd nr)
	sd final_nr
	setcall final_nr pref_call_align(nr)
	if final_nr!=0
		#Stack aligned on 16 bytes. Depending on the number of arguments, jumpCarry or jumpNotCarry
		sd err
		vdata code%ptrcodesec
		#bt rsp,3 (offset 3)
		chars hex_x={REX_Operand_64,0x0F,0xBA,bt_reg_imm8|espregnumber,3}
		#j(c|nc);sub rsp,8
		chars jump#1;chars *=4;chars *={REX_Operand_64,0x83,0xEC,8}

		and final_nr 1
		#Jump short if not carry
		if final_nr==0
			set jump (0x73)
		#Jump short if carry
		else;set jump (0x72)
		endelse

		SetCall err addtosec(#hex_x,(5+6),code)
		return err
	endif
	return (noerror)
endfunction
#nr
function pref_call_align(sd nr)
	data ptr_call_align%ptr_call_align
	sd type;set type ptr_call_align#
	if type!=(call_align_no)
		sd conv;setcall conv convdata((convdata_total))
		if nr<=conv
			if conv==(lin_convention)
				if type==(call_align_yes_all)
					return 2 #to align at no args
				endif
			else
				if type!=(call_align_yes_arg)
					return conv
				endif
			endelse
		else
			return nr
		endelse
	endif
	return 0
endfunction


#err
function align_ante(sd arguments)
	setcall arguments pref_call_align(arguments)
	if arguments!=0
		sd container%ptrstackAlign
		sd pointer;call getcontplusReg(container,#pointer)
		sub pointer (dwsz)
		#test if in a function
		sd fnboolptr%globalinnerfunction
		if fnboolptr#==(TRUE)
			sub pointer (dwsz)
		endif
		sd test=1;and test arguments
		sd test2=0xffFF
		if test==0
		#even, put on low word
			inc pointer#
			and test2 pointer#
			if test2!=0
				return (noerror)
			endif
			return "More than 65535 even calls?"
		endif
		#odd, put on high word
		sd bag;set bag pointer#
		div bag 0x10000
		inc bag
		and test2 bag
		if test2!=0x8000
			#set to high word
			#this is not endian independent add pointer (wsz)
			#and pointer#s^ bag
			#or pointer#s^ bag
			#div bag 0x100
			#inc pointer
			#and pointer#s^ bag
			#or pointer#s^ bag
			mult bag 0x10000
			sd bag2;set bag2 pointer#
			and bag2 bag;or bag2 bag
			and pointer# (0xffFF)
			or pointer# bag2
			return (noerror)
		endif
		return "32768 odd calls?"  #to div without sign
	endif
	return (noerror)
endfunction

function align_resolve()
	sd container%ptrstackAlign
	sd pointer;sd end;call getcontandcontReg(container,#pointer,#end)
	add end pointer
	while pointer!=end
		sd bag;set bag pointer#
		if bag!=0
			sd even=0xffFF;and even bag
			div bag 0x10000
			if even>=bag
				set pointer# (even_align)
			else
				set pointer# (odd_align)
			endelse
		endif
		add pointer (dwsz)
	endwhile
endfunction
