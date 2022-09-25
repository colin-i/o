

#wget in Makefile maybe

import lief

elffile = lief.parse("z")

#a64.out
#s=elffile.get_section(".data")

x=elffile.segments
x=x[3]

s=x.sections
for q in s:
	print(q)
ss=s[3]
data=s[2]


#print(data.size)
#print(x.virtual_size)
#print(ss.virtual_address)

#this is not better than objcopy file --update-section .data=data.bin
#data.content=bytearray(b"text")

#print(data.size)
print(x.virtual_size)
print(ss.virtual_address)

#The value of sh_addr must be congruent to 0, modulo the value of sh_addralign
#	i think that means   if align is 8 addr can start at 0h/8h only

#must first increase segment size if not want to lose the section
x.virtual_size+=0x1000
ss.virtual_address+=0x1000

#print(data.size)
print(x.virtual_size)
print(ss.virtual_address)

for q in s:
	print(q)

elffile.write("out.elf")
