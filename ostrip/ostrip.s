
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

entrylinux main(sd argc,ss *argv0,ss *exec,ss *obj1,ss *log1)   #... objN logN

if argc>(1+3)  #0 is all the time
	return (EXIT_SUCCESS)
endif
return (EXIT_FAILURE)
