

#wget in Makefile maybe

import subprocess
import sys

inputfile=sys.argv[1]

txt=subprocess.check_output(['/bin/bash','-c',"printf '%s' $(objdump -h "+inputfile+" | grep ' .data ' | tr -s ' ' | cut -d ' ' -f 4)"])
unstripped_size=int(txt,base=16)
#fn="temp"
#with open(fn,'rb') as f:
#	unstripped_size=int(f.read(),base=16)

#this is not better than objcopy file --update-section .data=data.bin
#data.content=bytearray(b"text")
#ld...-Tdata to put data at trail

import os

s1=".data"
s2=".text"
s3=".symtab"
if (os.path.exists(s3)):
	#objcopy is not updating symtab
	with open(s3+"_offset",'rb') as f:
		offset=int(f.read(),base=16)
	with open(inputfile,'+b') as f:
		f.seek(offset)
		with open(s3,'rb') as s:
			f.write(s.read())
subprocess.run(["objcopy",inputfile,"--update-section",s2+"="+s2,"--update-section",s1+"="+s1])

import lief

elffile = lief.parse(inputfile)

s=elffile.get_section(s1)

h=elffile.segments

found=-1

for x in h:
	a=x.sections
	n=len(a)
	for i in range(0,n):
		b=a[i]
		if found==-1:
			if s1==b.name:
				#only with .bss: it looks like objcopy is shrinking file size accordingly and is not touching on mem size in section and segment
				#so this file was about to go
				#but when it's at the edge is shrinking mem size
				#then x.virtual_size+= is a must and a[i].virtual_address+= stays like a guardian
				if (b.virtual_address+unstripped_size)<=(x.virtual_address+x.virtual_size):
					exit(0)
				found=i+1
				size=b.size
				dif=unstripped_size-size
		else:
			#see about alignments
			#The value of sh_addr must be congruent to 0, modulo the value of sh_addralign
			#	i think that means   if align is 8 addr can start at 0h/8h only
			test=b.virtual_address+dif
			bittest=test&(b.alignment-1)
			if bittest!=0:
				dif+=b.alignment-bittest
	if found!=-1:
		#must first increase segment size if not want to lose the section
		x.virtual_size+=dif
		for i in range(found,n):
			a[i].virtual_address+=dif
		elffile.write(sys.argv[1])
		#
		#point that this script is not checking the existent virtual trail of .data
		#remove(fn)
		#
		exit(0)

exit(-1)
