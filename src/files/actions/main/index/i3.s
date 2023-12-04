
SetCall errormsg xfile_add_char_if((Xfile_interrupt))
if errormsg=(noerror)
	Char interrupt={0xCC}
	vStr ptrinterrupt^interrupt
	SetCall errormsg addtosec(ptrinterrupt,bytesize,ptrcodesec)
endif
