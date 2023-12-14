
format elfobj64

const EXIT_SUCCESS=0
const EXIT_FAILURE=1

importx "puts" puts

entry main(sd argc)
	if argc=2
		return (EXIT_SUCCESS)
	end
	call puts("Usage otoc Xfile name")
	return (EXIT_FAILURE)
