
#err
function override_com(sd pcontent,sd psize)
	sd name
	sd namesize
	setcall namesize valinmem(pcontent#,psize#,(asciispace))
	if namesize==0
		return "first argument is missing at override"
	endif
	set name pcontent#
	call advancecursors(pcontent,psize,namesize)
	call spaces(pcontent,psize)
	if psize#==0
		return "second argument is missing at override"
	endif
	#work can be done do allow line comment here

	sd err
	ss mem
	sd valuesize;set valuesize psize#

	sd allocsize=1+1;add allocsize valuesize
	add allocsize namesize
	setcall err memoryalloc(allocsize,#mem)
	if err==(noerror)
		ss p;set p mem
		call memtomem(p,name,namesize);add p namesize
		set p# 0;inc p
		ss value;set value p
		call memtomem(p,pcontent#,valuesize);add p valuesize
		set p# 0
		setcall err prefs_set(mem,value)
		if err==(noerror)
			call advancecursors(pcontent,psize,valuesize)
		endif
		call free(mem)
	endif
	return err
endfunction
