
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
	#nm d mai intai;  la  c   nm dc
	#alt nm skip d ;  la  c   nm dc2
	#la sfarsit se ia cea mai mica, daca una este in toate gata
		incst argv
	endwhile
endif

return (EXIT_FAILURE)
