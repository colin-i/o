
#aftercall pointer (string)
function aftercall_find(sv objects,sv poffset)
	sd doffset=0
	while objects#!=(NULL)
		sv obj=to_symtab
		add obj objects#
		ss sym;set sym obj#
		incst obj
		sd end;set end obj#
		add end sym
		while sym!=end
#Data elf64_sym_st_name#1
#Chars elf64_sym_st_info#1
#Chars *elf64_sym_st_other={0}
#Chars elf64_sym_st_shndx#2
#Data elf64_sym_st_value#1;data *=0
#Data elf64_sym_st_size#1;data *=0
const sym__to_value=datasize+charsize+charsize+(2*charsize)
const sym_size=sym__to_value+:+:
			add sym (datasize+charsize+charsize)
			data d=dataind
			sd cmp;setcall cmp memcmp(sym,#d,2)
			if cmp==0
				sub sym (charsize+charsize)
				chars info=STB_GLOBAL*0x10|STT_NOTYPE;   #global seems to always be here but there is too much code to separate
				if info==sym#
				#this is the aftercall,get string pointer from strtab
					sub sym (datasize)
					incst obj
					sd mem;set mem obj#
					add mem sym#d^

					#and get offset in data
					add sym (sym__to_value)
					add doffset sym#v^
					add poffset# doffset

					return mem
				endif
			endif
		endwhile
		add obj (from_symsize_to_voffset)
		add doffset obj#d^
		incst objects
	endwhile
	return (NULL)
endfunction

function aftercall_replace(sv psym,sv pstr,ss astr,sv aoffset)
	sd sec;set sec pstr#
	incst pstr
	sd end;set end pstr#
	add end sec
	sd pos;setcall pos shnames_find(sec,end,astr)
	if pos!=-1
		set sec psym#
		incst psym
		set end psym#
		add end sec
		while sec!=end
			#name pos is first
			if sec#==pos
				add sec (sym__to_value)
				set sec#v^ aoffset
				ret
			endif
			add sec (sym_size)
		endwhile
	endif
endfunction
