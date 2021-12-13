
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
	#i tot, f tot; la sfarsit la fiecare f daca nu e in I gata
	#nm d mai intai;daca e primul   c  la  nm dc
	#alt nm skip d ;daca una 6 una 4, ceva de 6 cu nr, while la alea 4
	#               nr ar fi 2, raman 2
		incst argv
	endwhile
endif

return (EXIT_FAILURE)
