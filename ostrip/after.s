
#aftercall pointer (string)
function aftercall_find(sv objects)
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
			add sym (datasize+charsize+charsize)
			data d=dataind
			sd cmp;setcall cmp memcmp(sym,#d,2)
			if cmp==0
				sub sym (charsize+charsize)
				chars info=STB_GLOBAL*0x10|STT_NOTYPE;   #global seems to alwasy be here but there is too much code to separate
				if info==sym#
				#this is the aftercall,get string pointer from strtab
					sub sym (datasize)
					incst obj
					sd mem;set mem obj#
					add mem sym#d^
					return mem
				endif
			endif
		endwhile
		incst objects
	endwhile
	return (NULL)
endfunction
