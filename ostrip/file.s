
include "mem.s"

function get_file(sd name,sv p_file,sd type,sv secN,sv p_secN,sd pnrsec)
	setcall p_file# fopen(name,"rb")
	sd file;set file p_file#
	if file!=(NULL)
		#at frees will check next
		sv p;set p p_secN#
		set p# (NULL)

		chars elf64_ehd_e_ident_sign={asciiDEL,asciiE,asciiL,asciiF}
#chars *elf64_ehd_e_ident_class={ELFCLASS64}
#chars *elf64_ehd_e_ident_data={ELFDATA2LSB}
#chars *elf64_ehd_e_ident_version={EV_CURRENT}
#chars *elf64_ehd_e_ident_osabi={ELFOSABI_NONE}
#chars *elf64_ehd_e_ident_abiversion={EI_ABIVERSION}
#chars *elf64_ehd_e_ident_pad={0,0,0,0,0,0,0}
		const after_sign_to_type=1+1+1+1+1+7
#Chars *elf64_ehd_e_type={ET_REL,0}
		Chars elf64_ehd_e_machine={EM_X86_64,0}
#data *elf64_ehd_e_version=EV_CURRENT
#data *elf64_ehd_e_entry={0,0}
#data *elf64_ehd_e_phoff={0,0}
		const after_machine_to_shoff=4+8+8
#data elf64_ehd_e_shoff#1;data *=0
#data *elf64_ehd_e_flags=0
#chars *elf64_ehd_e_ehsize={64,0}
#chars *elf64_ehd_e_phentsize={0,0}
#chars *elf64_ehd_e_phnum={0,0}
		const after_shoff_to_shentsize=4+2+2+2
#chars *elf64_ehd_e_shentsize={64,0}
#chars elf64_ehd_e_shnum#2
#chars elf64_ehd_e_shstrndx#2
#chars *pad={0,0}
		sd sz=4
		sd sign;call read(file,#sign,sz)
		sd c;setcall c memcmp(#sign,#elf64_ehd_e_ident_sign,sz)
		if c==0
			call seekc(file,(after_sign_to_type))
			sd wsz=2
			sd w;call read(file,#w,wsz)
			setcall c memcmp(#w,#type,wsz)
			if c==0
				call read(file,#w,wsz)
				setcall c memcmp(#w,#elf64_ehd_e_machine,wsz)
				if c==0
					call seekc(file,(after_machine_to_shoff))
					sd offset;call read(file,#offset,:)
					call seekc(file,(after_shoff_to_shentsize))
					data shentsize=0
					data shnum=0
					data shstrndx=0
					call read(file,#shentsize,wsz)
					call read(file,#shnum,wsz)
					call read(file,#shstrndx,wsz)

					#alloc for section names table
					call shnames(file,offset,shentsize,shstrndx,secN,pnrsec)

					#get sections

					sd end;set end shnum;mult end shentsize;add end offset

					while secN#!=(NULL)
						set p p_secN#
						#next at frees
						set p# (NULL)  #this is extra only at first
						call get_section_many(file,offset,end,shentsize,pnrsec#,p_secN#)
						if p#==(NULL)
							ret
						endif
						add secN :
						add pnrsec (datasize)
						add p_secN :
					endwhile
					ret
				endif
				call erMessages("wrong machine",name)
			endif
			call erMessages("bad type",name)
		endif
		call erMessages("not an elf",name)
	endif
	call fError(name)
endfunction
function fError(ss name)
	call erMessages("fopen error for",name)
endfunction

function rError()
	call erMessage("fread error")
endfunction
function read(sd file,sd buf,sd size)
	sd readed;setcall readed fread(buf,1,size,file)
	if readed!=size
		call rError()
	endif
endfunction

function seekc(sd file,sd offset)
	call seek(file,offset,(SEEK_CUR))
endfunction
function seeks(sd file,sd offset)
	call seek(file,offset,(SEEK_SET))
endfunction
function seek(sd file,sd offset,sd whence)
	sd return;SetCall return fseek(file,offset,whence)
	#at lseek:
	#	beyond seekable device limit is not our concerne, error check at seekc can go if seeks was not
	#	at section headers offset, error can be demonstrated (bad offset)
	if return!=0
		call erMessage("fseek error")
	endif
endfunction

function shnames(sd file,sd offset,sd shentsize,sd shstrndx,sv secN,sd pnrsec)  #nrsec is int
	mult shstrndx shentsize
	add offset shstrndx

	sd mem;sd end;setcall end get_section(file,offset,#mem)
	add end mem
	#old remark:   count strings? safer than say it is the number of sections

	while secN#!=(NULL)
		setcall pnrsec# shnames_find(mem,end,secN#)
		add secN :
		add pnrsec (datasize)
	endwhile
	call free(mem)
endfunction

function get_section_many(sd file,sd offset,sd end,sd shentsize,sd nrsec,sv p_sec)
	while offset!=end
		#the sh64_name is first
		if offset#==nrsec
			call get_section(file,offset,p_sec)
			ret
		endif
		add offset shentsize
	endwhile
endfunction

#fread
function get_section(sd file,sd offset,sv pmem)
#Data sh64_name#1
#Data sh64_type#1
#Data sh64_flags#1;data *=0
#Data sh64_addr#1;data *=0
#Data sh64_offset#1;data *=0
#Data sh64_size#1;data *=0
#Data sh64_link#1
#Data sh64_info#1
#Data sh64_addralign#1;data *=0
#Data sh64_entsize#1;data *=0
	add offset (4+4+:+:)  #flags :?on 32 is ok
	call seeks(file,offset)
	call read(file,#offset,:)
	sd size;call read(file,#size,:)
	call seeks(file,offset)
	sd mem;setcall mem alloc(size)
	sd readed;setcall readed fread(file,mem,size)
	if readed==size
		set pmem# mem
		return size
	endif
	call free(mem)
	call rError()
endfunction
