
const variable_convention=lin_convention

#err
function prefextra(ss prefpath,sd ptrpreferencessize,sd ptrpreferencescontent)
	sd err
	setcall err prefextra_helper(prefpath,ptrpreferencessize,ptrpreferencescontent)
	if err!=(noerror)
		Call Message(err)
	endif
	return err
endfunction
#err
function prefextra_helper(ss prefpath,sd ptrpreferencessize,sd ptrpreferencescontent)
	sd err
	sd s2;setcall s2 strlen(prefpath)
	sd mem
	sd a

	#first verify in home
	ss homestr="HOME"
	ss envhome
	setcall envhome getenv(homestr)
	if envhome!=(NULL)
		sd s1;sd s3=2
		setcall s1 strlen(envhome);add s3 s1;add s3 s2
		setcall err memoryalloc(s3,#mem)
		if err==(noerror)
			call memtomem(mem,envhome,s1)
			ss p;set p mem;add p s1;set p# (asciislash);inc p
			call memtomem(p,prefpath,s2);add p s2;set p# (NULL)
			setcall a access(mem,(F_OK))
			if a==0
				SetCall err file_get_content_ofs(mem,ptrpreferencessize,ptrpreferencescontent,(NULL))
				if err==(noerror)
					call free(mem)
					return (noerror)
				endif
				call safeMessage(err)  #openfile has alloc err msg
			endif
			call free(mem)
		else
			return err
		endelse
	else
		call Message("Getenv error on HOME.")
	endelse

	#second verify in etc, note that there is not suposed to be a /usr/etc, /usr is read-only, so scrpath is not needed
	const prefextra_sz_const=1+3+1
	sd size=prefextra_sz_const+1;add size s2
	setcall err memoryalloc(size,#mem)
	if err==(noerror)
		call memtomem(mem,"/etc/",(prefextra_sz_const))
		ss pointer=prefextra_sz_const
		add pointer mem
		call memtomem(pointer,prefpath,s2)
		add pointer s2;set pointer# (NULL)
		setcall a access(mem,(F_OK))
		if a==0
			SetCall err file_get_content_ofs(mem,ptrpreferencessize,ptrpreferencescontent,(NULL)) #openfile cas alloc err msg
			if err==(noerror)
				call free(mem)
				return (noerror)
			endif
			Call safeMessage(err)  #openfile has alloc err msg
		else
			call Message("No preferences file found in etc.")
		endelse
		call free(mem)
	else
		return err
	endelse

	return "No preferences file found in HOME. The file is here: https://raw.githubusercontent.com/colin-i/o/master/.ocompiler.txt"
endfunction
