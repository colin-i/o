
importx "fseek" fseek
importx "ftell" ftell
importx "rewind" rewind
importx "malloc" malloc
importx "fread" fread
importx "free" free

const SEEK_END=2

einclude "../src/files/headers/xfile.h" "/usr/include/ocompiler/xfile.h"

function loop(sd input)
	sd a;set a fseek(input,0,(SEEK_END)) #on 32 can be -1 return error
	if a=0
		sd pointer;set pointer ftell(input) #is still same place if file deleted in parallel
		#if pointer!=-1  #lseek and same result (remark fileno)
		call rewind(input)
		ss buffer;set buffer malloc(size)
		if buffer!=(NULL)
			sd r;set r fread(buffer,pointer,1,input)
			if r=1
				add pointer buffer
				while buffer!=pointer
					sd command;set command buffer#
					inc buffer
				end
			end
			call free(buffer)
		end
	end
end
