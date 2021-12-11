
format elfobj

#EXIT_SUCCESS 0
const EXIT_FAILURE=1

entrylinux main(sd argc,ss argv0)

if argc>1
	mult argc :
	sv argv;set argv #argv0
	add argc argv
	incst argv
	while argv!=argc
	#get f i, get c+d r+d
		incst argv
	endwhile
endif

return (EXIT_FAILURE)
