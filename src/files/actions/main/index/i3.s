
If comsize=zero
	Char interrupt={0xCC}
	Str ptrinterrupt^interrupt
	SetCall errormsg addtosec(ptrinterrupt,bytesize,ptrcodesec)
endif
