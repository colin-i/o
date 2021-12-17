
importx "malloc" malloc
importx "realloc" realloc
importx "memcpy" memcpy

function alloc(sv p)
	sd mem=0
	setcall p# malloc(mem)
	if p#!=(NULL)
		sd m=:
		add m p
		set m# mem
		return (void)
	endif
	call erExit("malloc error")
endfunction

function ralloc(sv p,sd sz)
	sd mem;set mem p
	add mem :
	add sz mem#
	if sz>0
		setcall p# realloc(p#,sz)
		if p#!=(NULL)
			set mem# sz
			return (void)
		endif
		call erExit("realloc error")
	endif
	call erExit("realloc must stay in 31 bits")
endfunction

function addtocont(sv cont,ss s,sd sz)
	#old size
	sd oldsize
	set oldsize cont
	add oldsize :
	set oldsize oldsize#
	#
	#knowing ocompiler maxvaluecheck
	sd size=4
	add size sz
	call ralloc(cont,size)
	#
	add oldsize cont#
	set oldsize# sz
	add oldsize 4
	call memcpy(oldsize,s,sz)
endfunction
