
#must do a stripped .data and resolved .text (and .symtab)

#input: exec log1 o1 ... logN oN

format elfobj64
#modify debian/control exec depends,appimage.yml,debian/control arh order

#at exec
#there is a rare case with rela.dyn but it is not important here (resolved stderr to object)
#these are not position independent code and inplace relocs add better with obj64 but at obj32 use addend>=0 or sum<0 error check

#both exec and shared:
#	pointers to dataind at text/data
#	aftercall has a copy at .symtab

#only exec:
#	pointers to aftercall

#only at shared:
#	.rela.dyn:
#		addends from pointers to data section (this and the previous are saying the same thing but maybe is compatibility)
#		data section offsets (direct:^printf, pointers to text/data sections)
#	aftercall value at .dynsym

#pin about .data align at objects that ld respects when concatenating
#aftercall is retrieved in .symtab in an entry with Type=NOTYPE and Ndx=dataind, then .strtab for name, then in another objects an import with that name
#at exec instead of .strtab can be value is inside data(there are outside data values as well), but that's extra code
#aftercall can be resolved not from the first iteration

include "header.h"

include "throwless.s"
include "rel.s"

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
include "obj.s"

entrylinux main(sd argc,ss argv0,ss exec,ss log1,ss *obj1)   #... logN objN

if argc>(1+3)  #0 is all the time
	sv pfile%pexefile
	chars s1=".data";chars s2=".text"
	const s1c^s1;const s2c^s2
	value sN%{s1c,s2c,NULL}
	sv pexe%pexedata
	datax nrs#2   #this is required inside but is better than passing the number of sections

	#set here these(and sym for aftercall) null, text/data can go null later, with access error if rela points there
	sv pt%pexetext
	set pt# (NULL)
	#sv ps%pexesym
	#set ps# (NULL)
	#and set data null here, it is useless there for objects call
	set pexe# (NULL)   #data

	sv pobjects%pobjects
	set pobjects# (NULL) #this is on the main plan, is after ss exec at frees

	call get_file(exec,pfile,(ET_EXEC),#sN,pexe,#nrs)

	mult argc :
	add argc #argv0
	call get_objs(#log1,argc) #aftercall can be in any object, need to keep memory

	call objs_concat(pobjects#,pexe)

	call reloc(pobjects#)

	call write(#sN,pexe)

	call frees()
	return (EXIT_SUCCESS)
endif
return (EXIT_FAILURE)
