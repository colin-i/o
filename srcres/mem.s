
const dword=4

importx "malloc" malloc
importx "realloc" realloc
importx "memcpy" memcpy
importx "memcmp" memcmp

function malloc_throwless(sv p,sd sz)
	setcall p# malloc(sz)
	if p#!=(NULL)
		return (void)
	endif
	return "malloc error"
endfunction
function alloc(sv p)
	sd mem=0
	sd er
	setcall er malloc_throwless(p,mem)
	if er==(NULL)
		sd m=:
		add m p
		set m# mem
		return (void)
	endif
	call erExit(er)
endfunction

function ralloc_throwless(sv p,sd sz)
	sd mem;set mem p
	add mem :
	add sz mem#
	if sz>0
		setcall p# realloc(p#,sz)
		if p#!=(NULL)
			set mem# sz
			return (NULL)
		endif
		return "realloc error"
	endif
	return "realloc must stay in 31 bits"
endfunction
function ralloc(sv p,sd sz)
	sd er
	setcall er ralloc_throwless(p,sz)
	if er==(NULL)
		return (void)
	endif
	call erExit(er)
endfunction

function addtocont(sv cont,ss s,sd sz)
	#old size
	sd oldsize=:
	add oldsize cont
	set oldsize oldsize#
	#
	#knowing ocompiler maxvaluecheck
	sd size=dword
	add size sz
	call ralloc(cont,size)
	#
	add oldsize cont#
	set oldsize# sz
	add oldsize (dword)
	call memcpy(oldsize,s,sz)
endfunction
function addtocont_rev(sv cont,ss s,sd sz)
	#old size
	sd oldsize=:
	add oldsize cont
	set oldsize oldsize#
	#
	#knowing ocompiler maxvaluecheck
	sd size=dword
	add size sz
	call ralloc(cont,size)
	#
	add oldsize cont#
	call memcpy(oldsize,s,sz)
	add oldsize sz
	set oldsize# sz
endfunction

#-1/p
function pos_in_cont(sv cont,ss s,sd sz)
	sd mem=:
	add mem cont
	set mem mem#
	sd p
	set p cont#
	add mem p
	#sd i=0
	while p!=mem
		sd len
		set len p#
		add p (dword)
		if len==sz
			sd c
			setcall c memcmp(s,p,sz)
			if c==0
				#return i
				return 0
			endif
		endif
		add p len
		#inc i
	endwhile
	return -1
endfunction
