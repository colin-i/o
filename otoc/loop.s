
importx "fseek" fseek
importx "ftell" ftell
importx "rewind" rewind
importx "malloc" malloc
importx "fread" fread
importx "free" free

const SEEK_END=2

function loop(sd input)
	sd a;set a fseek(input,0,(SEEK_END))
	if a=0
		sd size;set size ftell(input)
		if size!=-1
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
end
