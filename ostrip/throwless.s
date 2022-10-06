
importx "fclose" fclose

function frees()
	valuex exefile#1
	const pexefile^exefile
	if exefile!=(NULL)
		call fclose(exefile)
	endif
endfunction
