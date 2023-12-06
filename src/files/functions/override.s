
#err
function override_com(sv pcontent,sd psize,sd parses)
	sd name
	sd namesize
	setcall namesize valinmem(pcontent#,psize#,(asciispace))
	if namesize=0
		return "first argument is missing at override"
	endif
	set name pcontent#
	call advancecursors(pcontent,psize,namesize)
	call spaces(pcontent,psize)
	if psize#=0
		return "second argument is missing at override"
	endif

	sd err
	ss mem
	sd valuesize;setcall valuesize find_whitespaceORcomment(pcontent#,psize#)

	sd allocsize=1+1;add allocsize valuesize
	add allocsize namesize
	setcall err memoryalloc(allocsize,#mem)
	if err=(noerror)
		ss p;set p mem
		call memtomem(p,name,namesize);add p namesize
		set p# 0;inc p
		ss value;set value p
		call memtomem(p,pcontent#,valuesize);add p valuesize
		set p# 0
		ss pointer;setcall err prefs_set(mem,value,#pointer) #pointer here is not required but at xfile is, and is faster this way
		if err=(noerror)
			call advancecursors(pcontent,psize,valuesize)
			if parses=(pass_write)
				setcall err xfile_add_override_if(mem,namesize,pointer#)
			endif
		endif
		call free(mem)
	endif
	return err
endfunction
