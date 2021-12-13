
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
	#i all, f all; at end every f not i I, failure
	#nm d;first c inside
	#another log; files same; one c has some point in previous files same
	#             decisions there
		incst argv
	endwhile
endif

return (EXIT_FAILURE)
