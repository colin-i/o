
importx "fseek" fseek
importx "ftell" ftell
importx "rewind" rewind
importx "malloc" malloc
importx "fread" fread
importx "free" free

const SEEK_END=2

function loop(sd input)
	sd a;set a fseek(input,0,(SEEK_END)) #on 32 can be -1 return error
	if a=0
		sd size;set size ftell(input) #is still same place if file deleted in parallel
		#if size!=-1  #lseek and same result (remark fileno)
		call rewind(input)
		sd buffer;set buffer malloc(size)
		if buffer!=(NULL)
			sd r;set r fread(buffer,size,1,input)
			if r=1
			end
			call free(buffer)
		end
	end
end
