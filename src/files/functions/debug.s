
#er
function debug_lines(sd reg,sd line)
	datax prevLine#1
	const ptrprevLineD^prevLine
	datax codeRegD#1
	const ptrcodeRegD^codeRegD
	#initialized values

	if line!=prevLine   #no a[semicolon]b column atm
		#set line
		sd aux;set aux prevLine;set prevLine line
		if reg!=codeRegD
			sv ptrdebug%%ptr_debug
			chars a=log_line
			sd err
			setcall err addtosec(#a,(bsz),ptrdebug)
			if err==(noerror)
				charsx buf#dw_chars_0
				sd len
				inc aux
				setcall len dwtomem(aux,#buf)
				setcall err addtosec(#buf,len,ptrdebug)
				if err==(noerror)
					chars b=asciispace
					setcall err addtosec(#b,(bsz),ptrdebug)
					if err==(noerror)
						setcall len dwtomem(codeRegD,#buf)
						setcall err addtosec(#buf,len,ptrdebug)
						if err==(noerror)
							sd t;sd sz;setcall t log_term(#sz)
							setcall err addtosec(t,sz,ptrdebug)
							#set codeReg
							set codeRegD reg
						endif
					endif
				endif
			endif
			return err
		endif
	endif
	return (noerror)
endfunction
