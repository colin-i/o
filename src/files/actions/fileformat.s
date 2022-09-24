
#this is temporary
setcall errormsg set_reserve(datasecSize)
if errormsg!=(noerror)
	Call msgerrexit(errormsg)
endif
#

If fileformat==pe_exec
	Include "./fileformat/pe_struct.s"
	Include "./fileformat/pe_resolve.s"
Else
	Include "./fileformat/elf_resolve.s"
EndElse
