
importx "fwrite" fwrite

function resolve(sd j)
	sv fns%fn_mem_p
	sd mem=:
	add mem fns
	set mem mem#
	sd p
	set p fns#
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
	Call fprintf(st#,"%u files, %u %s resolved.",j,i,f)
	call messagedelim()
endfunction

function wrongExit(ss x,ss n,sd len)
	sv st^stderr
	set st st#
	Call fprintf(st,"Unused %s: ",x)
	call fwrite(n,len,1,st)
	call erExit("")
endfunction
