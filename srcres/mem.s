
const dword=4

importx "malloc" malloc
importx "realloc" realloc
importx "memcpy" memcpy
importx "memcmp" memcmp

#data
function m_alloc(sd sz)
	sd m
	setcall m malloc(sz)
	if m!=(NULL)
		return m
	endif
	call erExit("malloc error")
endfunction

function alloc(sv p)
	sd mem=0
	setcall p# m_alloc(mem)
	sd m=:
	add m p
	set m# mem
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
function addtocont_value(sv cont,sd value)
	sd oldsize=:
	add oldsize cont
	set oldsize oldsize#
	call ralloc(cont,(dword))
	set cont cont#
	add cont oldsize
	set cont# value
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
