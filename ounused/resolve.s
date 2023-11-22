
function resolve(sd j)
	sv cont%fn_mem_p
	sd p
	sd mem
	set p cont#
	add cont :
	set mem cont#d^
	add mem p
	#set mem cont#d^;add cont (dword);set p cont#;add mem p
	sv imps%imp_mem_p
	sd i=0
	vstr f="function"
	while p!=mem
		sd len
		set len p#
		add p (dword)
		sd pos
		setcall pos pos_in_cont(imps,p,len)
		if pos=-1
			call wrongExit(f,p,len)
		endif
		add p len
		inc i
	endwhile
	vstr c="constant"
	vstr v="variable"
	call uconst_resolve(c,v)
	sd k
	setcall k uconst_resolved(2)
	#
	sv st^stderr
	sd fls
	setcall fls filessize()
	div fls :
	sd imps_sz
	setcall imps_sz importssize()
	sd const_sz
	setcall const_sz constssize()
	Call fprintf(st#,"%u logs, %u files, %u unique imports, %u %s/%s, %u %s resolved, %u %s/%s resolved.",j,fls,imps_sz,const_sz,c,v,i,f,k,c,v)
	call messagedelim()

	sv so^stdout
	call fflush(so#) #there is no line end at stdout, then flush is required
endfunction

function wrongExit(ss x,ss n,sd len)
	sv st^stderr
	set st st#
	Call fprintf(st,"Unused %s: ",x)
	call fwrite(n,len,1,st)
	call erExit("")
endfunction
