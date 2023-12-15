
importx "getline" getline
importx "free" free

function loop(sd input)
	sd buffer=NULL
	#This buffer should be freed by the user program even if getline() failed
	#On error, malloc returns NULL
	#free, If ptr is NULL, no operation is performed
	sd size=0

	while size!=-1
		set size getline(#buffer,#size,input)
	end
	call free(buffer)
end
