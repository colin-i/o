
#must do a stripped data.bin and resolved text.bin

#input: exec o1 log1 ... oN logN

format elfobj64
#modify debian/control exec depends,appimage.yml,debian/control arh order

#at exec only pointers to dataind at text/data
#there is a rare case with rela.dyn but it is not important here (resolved stderr to object)
#these are not position independent code and inplace relocs add better with obj64 but at obj32 use addend>=0 or sum<0 error check

#at shared: pointers
#	.rela.dyn:
#		addends from pointers to data section (this and the previous are saying the same thing but maybe is compatibility)
#		data section offsets (direct:printf, pointers to text/data sections)

const EXIT_SUCCESS=0
const EXIT_FAILURE=1
const NULL=0

const asciiDEL=0x7F
const asciiE=0x45
const asciiL=0x4C
const asciiF=0x46

Const SEEK_SET=0
Const SEEK_CUR=1

const ET_EXEC=2
const EM_X86_64=62

Importx "stderr" stderr
Importx "fprintf" fprintf

include "throwless.s"

function messagedelim()
	sv st^stderr
	Chars visiblemessage={0x0a,0}
	Call fprintf(st#,#visiblemessage)
endfunction
Function Message(ss text)
	sv st^stderr
	Call fprintf(st#,text)
	call messagedelim()
EndFunction
function erMessage(ss text)
	call Message(text)
	call erEnd()
endfunction
function erMessages(ss m1,ss m2)
	call Message(m1)
	call Message(m2)
	call erEnd()
endfunction
function erEnd()
	call frees()
	aftercall er
	set er (~0)
	return (EXIT_FAILURE)
endfunction

include "file.s"

entrylinux main(sd argc,ss *argv0,ss exec,ss *obj1,ss *log1)   #... objN logN

if argc>(1+3)  #0 is all the time
	sd text
	sd data;setcall data get_file(exec,".data",".text",#text,(ET_EXEC))
	if data!=(NULL)
	endif
	call frees()
	return (EXIT_SUCCESS)
endif
return (EXIT_FAILURE)
