
#err
function override_com(sd pcontent,sd psize)
	sd size
	setcall size valinmem(pcontent#,psize#,(asciispace))
	if size==0
		return "first argument is missing at override"
	endif
	sd name
	set name pcontent#
	call advancecursors(pcontent,psize,size)
	call spaces(pcontent,psize)
	if size==0
		return "second argument is missing at override"
	endif
	sd err
	sd p
	#work can be done do allow line comment here
	setcall err memoryalloc(size,#p)
	#it is file_get_content memwise (not strwise with null ending)
	if err==(noerror)
		inc size
		call memtomem(p,pcontent#,size)
		ss t;set t p;add t size;dec t;set t# 0
		setcall err prefs_set(name,p)
		call free(p)
	endif
	return err
endfunction
