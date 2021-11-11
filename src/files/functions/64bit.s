

#p_bits
function p_is_for_64()
	data bool#1
	return #bool
endfunction
#bool
function is_for_64()
	sd p;setcall p p_is_for_64();return p#
endfunction
#p_bits
function p_neg_is_for_64()
	data bool#1
	return #bool
endfunction

#get
function is_for_64_is_impX_or_fnX_p_get();data b#1;return #b;endfunction
#get
function is_for_64_is_impX_or_fnX_get();sd p_b;setcall p_b is_for_64_is_impX_or_fnX_p_get();return p_b#;endfunction
function is_for_64_is_impX_or_fnX_set(sd ptrdata)
	sd p_b
	setcall p_b is_for_64_is_impX_or_fnX_p_get()
	#importX and functionX already has a test with is_for_64
	add ptrdata (maskoffset)
	sd val;set val ptrdata#;and val (x86_64bit)
	if val!=(x86_64bit);set p_b# (FALSE);return (void);endif
	set p_b# (TRUE)
endfunction

#get
function nr_of_args_64need_p_get();data n#1;return #n;endfunction
#er
function nr_of_args_64need_set()
	sd p_b;setcall p_b is_for_64_is_impX_or_fnX_p_get()
	if p_b#==(TRUE)
		sd p;setcall p nr_of_args_64need_p_get();set p# 0
		#Stack aligned on 16 bytes. Later set, depending on the number of arguments, jumpCarry or jumpNotCarry
		sd err
		data code%ptrcodesec
		#bt rsp,3 (offset 3)
		chars hex_x={REX_Operand_64,0x0F,0xBA,bt_reg_imm8|espregnumber,3}
		SetCall err addtosec(#hex_x,5,code);If err!=(noerror);Return err;EndIf
		#
		sd stack_align_p;setcall stack_align_p stack_align_off_p_get()
		call getcontReg(code,stack_align_p)
		#j(c|nc);sub rsp,8
		chars jump#1;chars *=4;chars *={REX_Operand_64,0x83,0xEC,8}
		SetCall err addtosec(#jump,6,code);If err!=(noerror);Return err;EndIf
	endif
	Return (noerror)
endfunction
function nr_of_args_64need_count()
	sd p_b;setcall p_b is_for_64_is_impX_or_fnX_p_get()
	if p_b#==(TRUE)
		sd p;setcall p nr_of_args_64need_p_get();inc p#
	endif
endfunction
#nr_of_args
function nr_of_args_64need()
	sd n;setcall n nr_of_args_64need_p_get();return n#
endfunction
#p
function stack_align_off_p_get()
	data o#1;return #o
endfunction



##REX_W
#size of prefix(=1)
function rex_w(sd p_err)
	Data code%ptrcodesec
	chars r=REX_Operand_64;data sz=1
	SetCall p_err# addtosec(#r,sz,code)
	return sz
endfunction
#er
function rex_w_if64()
	sd b;setcall b is_for_64()
	if b==(FALSE)
		return (noerror)
	endif
	sd err
	call rex_w(#err)
	return err
endfunction

function stack64_op_set()
	sd b;setcall b is_for_64()
	if b==(TRUE);call stack64_op_set_get((TRUE),(TRUE));endif
endfunction
#(false)get
function stack64_op_set_get(sd b,sd val)
	data x#1
	if b==(TRUE);set x val
	else;return x
	endelse
endfunction
#err
function stack64_op(sd takeindex,sd p_mod)
	sd b;setcall b stack64_op_set_get((FALSE))
	if b==(FALSE);return (noerror);endif
	#reset
	call stack64_op_set_get((TRUE),(FALSE))
	#return if outside mod=3
	if p_mod#==(RegReg);return (noerror);endif
	
	sd err
	SetCall err val64_phase_3();If err!=(noerror);Return err;EndIf
	
	#set outside mod=3
	set p_mod# (RegReg)
	#mov reg,[reg]
	chars x=moveatprocthemem;chars y#1
	setcall y formmodrm((mod_0),takeindex,takeindex)
	data code%ptrcodesec
	setcall err addtosec(#x,2,code)
	return err
endfunction

function stack64_add(sd val)
	sd b;setcall b is_for_64()
	if b==(TRUE)
		mult val 2
	endif
	return val
endfunction

#setx

function val64_phase_0()
	sd p;setcall p val64_p_get();set p# 0
endfunction
function val64_phase_1()
	sd b;setcall b is_for_64()
	if b==(TRUE)
		sd p;setcall p val64_p_get();set p# (val64_willbe)
	endif
endfunction
#er
function val64_phase_3()
	sd p;setcall p val64_p_get()
	if p#==2
		sd er;call rex_w(#er);if er!=(noerror);return er;endif
		set p# 0
	endif
	return (noerror)
endfunction
function val64_p_get()
	data x#1;return #x
endfunction

function winconv(sd dest,sd is_call)
	if is_call==(TRUE)
		#rcx,[rsp+0]
		chars hex_1={REX_Operand_64,0x8B,0x0C,0x24}
		#rdx,rsp+8
		chars hex_2={REX_Operand_64,0x8B,0x54,0x24,0x08}
		#r8,rsp+16
		chars hex_3={REX_R8_15,0x8B,0x44,0x24,0x10}
		#r9,rsp+24
		chars hex_4={REX_R8_15,0x8B,0x4C,0x24,0x18}
		set dest# #hex_1
		add dest :;set dest# #hex_2
		add dest :;set dest# #hex_3
		return #hex_4
	endif
	const functionx_start=!
	#mov [rsp+8h],rcx
	chars functionx_code={REX_Operand_64,moveatmemtheproc,0x4C,0x24,0x08}
	#mov [rsp+10h],rdx
	chars *={REX_Operand_64,moveatmemtheproc,0x54,0x24,0x10}
	#mov [rsp+18h],r8
	chars *={REX_R8_15,moveatmemtheproc,0x44,0x24,0x18}
	#mov [rsp+20h],r9
	chars *={REX_R8_15,moveatmemtheproc,0x4C,0x24,0x20}
	set dest# (!-functionx_start)
	return #functionx_code
endfunction

function function_call_64fm(sd nr_of_args,sd hex_1,sd hex_2,sd hex_3,sd hex_4,sd code)
	sd err
	if nr_of_args>0
		SetCall err addtosec(hex_1,4,code);If err!=(noerror);Return err;EndIf
		if nr_of_args>1
			SetCall err addtosec(hex_2,5,code);If err!=(noerror);Return err;EndIf
			if nr_of_args>2
				SetCall err addtosec(hex_3,5,code);If err!=(noerror);Return err;EndIf
				if nr_of_args>3
					SetCall err addtosec(hex_4,5,code);If err!=(noerror);Return err;EndIf
				endif
			endif
		endif
	endif
	return err
endfunction
function function_call_64f(sd hex_1,sd hex_2,sd hex_3,sd hex_4,ss args_push,sd hex_x,sd conv,sd code)
	sd err
	sd nr_of_args;setcall nr_of_args nr_of_args_64need()
	#
	setcall err function_call_64fm(nr_of_args,hex_1,hex_2,hex_3,hex_4,code);If err!=(noerror);Return err;EndIf
	#
	#shadow space
	set args_push# conv
	if nr_of_args<args_push#;set args_push# nr_of_args;endif
	sub args_push# conv;mult args_push# -1
	if args_push#!=0
		mult args_push# (qwsz)
		call rex_w(#err);If err!=(noerror);Return err;EndIf
		SetCall err addtosec(hex_x,3,code);If err!=(noerror);Return err;EndIf
	endif
	#stack align,more to see when the offset was taken
	sd stack_align_p;setcall stack_align_p stack_align_off_p_get()
	ss code_pointer;call getcont(code,#code_pointer)
	add code_pointer stack_align_p#
	sd against_one;if nr_of_args>conv;set against_one nr_of_args;else;set against_one conv;endelse;and against_one 1
	#Jump short if not carry
	if against_one==0;set code_pointer# (0x73)
	#Jump short if carry
	else;set code_pointer# (0x72);endelse
	return (noerror)
endfunction
function function_call_64(sd is_callex,sd conv)
	sd err
	Data code%ptrcodesec
	#
	#sub esp,x;default 4 args stack space convention
	chars hex_x={0x83,0xEC};chars args_push#1
	sd hex_1;sd hex_2;sd hex_3;sd hex_4
	setcall hex_4 winconv(#hex_1,(TRUE))
	#
	if is_callex==(FALSE)
		setcall err function_call_64f(hex_1,hex_2,hex_3,hex_4,#args_push,#hex_x,conv,code)
		Return err
	endif
	#
	#cmp eax,imm32
	chars cmp_je=0x3d;data cmp_imm32#1
	#jump
	chars callex_jump#1;chars j_off#1
	##
	#mov eax,ebx
	chars find_args={0x8b,0xc3}
	#sub eax,esp
	chars *={0x2b,0xc4}
	#edx=0;ecx=QWORD;div edx:eax,ecx
	chars *=0xba;data *=0;chars *=0xb9;data *=qwsz;chars *={0xF7,0xF1}
	#
	SetCall err addtosec(#find_args,0x10,code);If err!=(noerror);Return err;EndIf
	#jump if equal
	set callex_jump (0x74)
	#
	set cmp_imm32 0
	sd j_nr=5+7
	set j_off conv;dec j_off;mult j_off j_nr;add j_off 4
	SetCall err addtosec(#cmp_je,7,code);If err!=(noerror);Return err;EndIf
		SetCall err addtosec(hex_1,4,code);If err!=(noerror);Return err;EndIf
	#
		set cmp_imm32 1
		sub j_off j_nr;inc j_off
		SetCall err addtosec(#cmp_je,7,code);If err!=(noerror);Return err;EndIf
			SetCall err addtosec(hex_2,5,code);If err!=(noerror);Return err;EndIf
	#
			set cmp_imm32 2
			sub j_off j_nr
			SetCall err addtosec(#cmp_je,7,code);If err!=(noerror);Return err;EndIf
				SetCall err addtosec(hex_3,5,code);If err!=(noerror);Return err;EndIf
	#
				set cmp_imm32 3
				sub j_off j_nr
				SetCall err addtosec(#cmp_je,7,code);If err!=(noerror);Return err;EndIf
					SetCall err addtosec(hex_4,5,code);If err!=(noerror);Return err;EndIf
	#jump if above
	set callex_jump (0x77)
	set args_push (qwsz)
	#
	set cmp_imm32 3
	set j_nr (3+7)
	set j_off conv;dec j_off;mult j_off j_nr;add j_off 3
	#4*REX.W
	add j_off conv
	SetCall err addtosec(#cmp_je,7,code);If err!=(noerror);Return err;EndIf
		subcall j_off rex_w(#err);If err!=(noerror);Return err;EndIf
		SetCall err addtosec(#hex_x,3,code);If err!=(noerror);Return err;EndIf
		set cmp_imm32 2
		sub j_off j_nr
		SetCall err addtosec(#cmp_je,7,code);If err!=(noerror);Return err;EndIf
			subcall j_off rex_w(#err);If err!=(noerror);Return err;EndIf
			SetCall err addtosec(#hex_x,3,code);If err!=(noerror);Return err;EndIf
			set cmp_imm32 1
			sub j_off j_nr
			SetCall err addtosec(#cmp_je,7,code);If err!=(noerror);Return err;EndIf
				subcall j_off rex_w(#err);If err!=(noerror);Return err;EndIf
				SetCall err addtosec(#hex_x,3,code);If err!=(noerror);Return err;EndIf
				set cmp_imm32 0
				sub j_off j_nr
				SetCall err addtosec(#cmp_je,7,code);If err!=(noerror);Return err;EndIf
					call rex_w(#err);If err!=(noerror);Return err;EndIf
					SetCall err addtosec(#hex_x,3,code);If err!=(noerror);Return err;EndIf
	return (noerror)
endfunction
#err
function function_start_64()
	Data code%ptrcodesec
	sd data;sd sz
	setcall data winconv(#sz,(FALSE))
	sd err
	SetCall err addtosec(data,sz,code)
	return err
endfunction
#err
function callex64_call(sd conv)
	#Stack aligned on 16 bytes.
	const callex64_start=!
	#bt rsp,3 (bit offset 3)
	chars callex64_code={REX_Operand_64,0x0F,0xBA,bt_reg_imm8|espregnumber,3}
	#jc @ (jump when rsp=....8)
	chars *=0x72;chars *=6+2+4+2+2
	#6cmp ecx,5
	chars *={0x81,0xf9};data jcase1#1
	set jcase1 conv;inc jcase1
	#2jb $
	chars *=0x72;chars *=4+2+2+6+2+4+2+4
	#4bt ecx,0
	chars *={0x0F,0xBA,bt_reg_imm8|ecxregnumber,0}
	#2jc %
	chars *=0x72;chars *=2+6+2+4+2
	#2jmp $
	chars *=0xEB;chars *=6+2+4+2+4
	#6@ cmp ecx,5
	chars *={0x81,0xf9};data jcase2#1
	set jcase2 conv;inc jcase2
	#2jb %
	chars *=0x72;chars *=4+2
	#4bt ecx,0
	chars *={0x0F,0xBA,bt_reg_imm8|ecxregnumber,0}
	#2jc $
	chars *=0x72;chars *=4
	#4% sub rsp,8
	chars *={REX_Operand_64,0x83,0xEC};chars *=8
	#$
	sd ptrcodesec%ptrcodesec
	sd err
	SetCall err addtosec(#callex64_code,(!-callex64_start),ptrcodesec)
	return err
endfunction
