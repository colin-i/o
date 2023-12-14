
format elfobj64

const EXIT_SUCCESS=0
const EXIT_FAILURE=1
const NULL=0

importx "puts" puts
importx "fopen" fopen
importx "fclose" fclose

entry main(sd argc,sv argv)
	if argc=2
		incst argv
		sd f;setcall f fopen(argv#,"rb")
		if f!=(NULL)
			call fclose(f)
			return (EXIT_SUCCESS)
		end
		call puts("Cannot open main file")
		return (EXIT_FAILURE)
	end
	call puts("Usage otoc Xfile name")
	return (EXIT_FAILURE)
