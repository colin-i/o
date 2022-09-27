

#wget in Makefile maybe

with open("temp",'rb') as f:
	unstripped_size=int(f.read(),base=16)

import lief

import sys

elffile = lief.parse(sys.argv[1])

c=".data"

s=elffile.get_section(c)

h=elffile.segments

found=-1

for x in h:
	a=x.sections
	n=len(a):
	for i in range(0,n):
		b=a[i]
		if ready==False:
			if c==b.name:
				found=i+1
				size=b.size
				dif=unstripped_size-size
		else:
			#see about alignments
			#The value of sh_addr must be congruent to 0, modulo the value of sh_addralign
			#	i think that means   if align is 8 addr can start at 0h/8h only
			test=b.virtual_address+dif
			bittest=test&(test.alignment-1)
			if bittest!=0:
				dif+=test.alignment-bittest
	if found!=-1:
		#must first increase segment size if not want to lose the section
		x.virtual_size+=dif
		for i in range(found,n):
			a[i].virtual_address+=dif
		elffile.write(sys.argv[1])
		exit(0)

exit(-1)

#this is not better than objcopy file --update-section .data=data.bin
#data.content=bytearray(b"text")
