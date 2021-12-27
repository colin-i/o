
importx "fwrite" fwrite

function resolve(sd j)
	sv cont%fn_mem_p
	sd p
	sd mem

#	set mem cont#d^
#	add cont (dword)
#	set p cont#

	set p cont#
	add cont :
	set mem cont#d^

	add mem p

	sv imps%imp_mem_p
	sd i=0
	str f="function"
	while p!=mem
		sd len
		set len p#
		add p (dword)
		sd pos
		setcall pos pos_in_cont(imps,p,len)
		if pos==-1
			call wrongExit(f,p,len)
		endif
		add p len
		inc i
	endwhile
	sv st^stderr
	sd fls
	setcall fls filessize()
	Call fprintf(st#,"%u logs, %u files, %u %s resolved.",j,fls,i,f)
	call messagedelim()
endfunction

function wrongExit(ss x,ss n,sd len)
	sv st^stderr
	set st st#
	Call fprintf(st,"Unused %s: ",x)
	call fwrite(n,len,1,st)
	call erExit("")
endfunction
