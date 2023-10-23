

function imm_values(sd ptrcontent,sd ptrsize,sd sz,sd outvalue)
#parenthesis is already verified
	call stepcursors(ptrcontent,ptrsize)
	dec sz
	dec sz
	sd err
	setcall err imm_value(ptrcontent,ptrsize,sz,outvalue)
	return err
endfunction
function imm_value(sd ptrcontent,sd ptrsize,sd sz,sd outvalue)
	sd err
	setcall err parseoperations(ptrcontent,ptrsize,sz,outvalue,(FALSE))
	return err
endfunction

function canbeimm_orerror(sd ptrcontent,sd ptrsize,sd sz,sd outvalue)
#size is not 0(zero)
	ss content
	set content ptrcontent#

	sd err

	if content#!=(asciiparenthesisstart)
		#this was the old form:
		#setcall err numbersconstants(content,sz,outvalue)
		#since xfile: parseoperations has xfile..done and it is better to exclude the parenthesis
		#it is also good to have operations
		#0+constant if want to start with a constant
		value ff^imm_value
		setcall err restore_cursors_onok(ptrcontent,ptrsize,ff,sz,outvalue)
		return err
	endif
	value f^imm_values
	setcall err restore_cursors_onok(ptrcontent,ptrsize,f,sz,outvalue)
	return err
endfunction

#err
function findimm(data ptrcontent,data ptrsize,data sz,data outvalue)
#size is not 0(zero)
	data canhaveimm#1
	const immpointer^canhaveimm
	data isimm#1
	const ptr_isimm^isimm

	Data noerr=noerror
	sd err
	setcall err canbeimm_orerror(ptrcontent,ptrsize,sz,outvalue)
	if err!=noerr
		return err
	endif

	data true=1
	set isimm true
	return noerr
endfunction


function setimm()
	data ptratimm%immpointer
	data true=1
	set ptratimm# true
endfunction
function unsetimm()
	data ptratimm%immpointer
	data false=0
	set ptratimm# false
endfunction
function getimm()
	data ptratimm%immpointer
	return ptratimm#
endfunction


function resetisimm()
	data ptr%ptr_isimm
	data false=0
	set ptr# false
endfunction
function getisimm()
	data ptr%ptr_isimm
	return ptr#
endfunction


function storefirst_isimm()
	data firstimm#1
	const ptr_first_isimm^firstimm
	data ptr%ptr_isimm
	set firstimm ptr#
endfunction
function restorefirst_isimm()
	data first%ptr_first_isimm
	data ptr%ptr_isimm
	set ptr# first#
endfunction
function getfirst_isimm()
	data first%ptr_first_isimm
	return first#
endfunction

function switchimm()
	data ptr%ptr_isimm
	data true=1
	#first was false was low at comparations low vs high
	if ptr#==true
		data first%ptr_first_isimm
		set first# true
		data false=0
		set ptr# false
	endif
endfunction


#er
function write_imm(sd dataarg,sd op)
	char immop#1
	data value#1
	data immadd^immop
	set immop op
	set value dataarg
	data sz=5
	data code%%ptr_codesec
	sd err
	setcall err addtosec(immadd,sz,code)
	call resetisimm()
	return err
endfunction
#er
function write_imm_sign(sd dataarg,sd regopcode)
	vData codeptr%%ptr_codesec
	sd err
	setcall err rex_w_if64()
	if err==(noerror)
		char movs_imm=mov_imm_to_rm
		SetCall err addtosec(#movs_imm,1,codeptr)
		if err==(noerror)
			sd op
			SetCall op formmodrm((RegReg),0,regopcode)
			setcall err write_imm(dataarg,op)
		endif
	endif
	return err
endfunction
#err
function write_imm_trunc(sd value,sd reg,sd low,sd data,sd sufix)
	sd err
	if low==(FALSE)
		sd bool;setcall bool is_big_imm(data,sufix)
		if bool==(FALSE)
			#mediu
			add reg (ateaximm)
			setcall err write_imm(value,reg)
			return err
		endif
		#big
		setcall err write_imm_sign(value,reg)  #there is one if64 useless inside
		return err
	endif
	#low
	char a#2
	ss b^a;set b# (atalimm)
	add b# reg
	inc b
	set b# value
	dec b
	vData codeptr%%ptr_codesec
	setcall err addtosec(b,2,codeptr)
	return err
endfunction
