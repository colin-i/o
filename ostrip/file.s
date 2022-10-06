
Importx "fopen" fopen
Importx "memcmp" memcmp

#p_sec1
function get_file(sd name,sd *sec1,sd *sec2,sd *p_sec2)
	sd file;setcall file fopen(name,"r")
	if file!=(NULL)
		chars elf64_ehd_e_ident_sign={asciiDEL,asciiE,asciiL,asciiF}
#chars *elf64_ehd_e_ident_class={ELFCLASS64}
#chars *elf64_ehd_e_ident_data={ELFDATA2LSB}
#chars *elf64_ehd_e_ident_version={EV_CURRENT}
#chars *elf64_ehd_e_ident_osabi={ELFOSABI_NONE}
#chars *elf64_ehd_e_ident_abiversion={EI_ABIVERSION}
#chars *elf64_ehd_e_ident_pad={0,0,0,0,0,0,0}
#Chars *elf64_ehd_e_type={ET_REL,0}
#Chars *elf64_ehd_e_machine={EM_X86_64,0}
#data *elf64_ehd_e_version=EV_CURRENT
#data *elf64_ehd_e_entry={0,0}
#data *elf64_ehd_e_phoff={0,0}
#data elf64_ehd_e_shoff#1;data *=0
#data *elf64_ehd_e_flags=0
#chars *elf64_ehd_e_ehsize={64,0}
#chars *elf64_ehd_e_phentsize={0,0}
#chars *elf64_ehd_e_phnum={0,0}
#chars *elf64_ehd_e_shentsize={64,0}
#chars elf64_ehd_e_shnum#2
#chars elf64_ehd_e_shstrndx#2
#chars *pad={0,0}
		sd sz=4
		sd sign;call read(file,#sign,sz)
		sd c;setcall c memcmp(#sign,#elf64_ehd_e_ident_sign,sz)
		if c==0
			valuex sec1_mem_sz#2
			return #sec1_mem_sz
		endif
		call erMessages("not an elf",name)
	endif
	call erMessages("fopen error for",name)
endfunction

function read(sd file,sd buf,sd size)
	sd readed;setcall readed read(file,buf,size)
	if readed!=size
		call erMessage("fread error")
	endif
endfunction
