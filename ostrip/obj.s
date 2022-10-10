
const object_nr_of_sections=2
const section_alloc=:*section_nr_of_values
const object_alloc_secs=object_nr_of_sections*section_alloc
const object_alloc=object_alloc_secs+datasize+:

##stripped size
function get_objs(sv args,sd end)
	#find the number of objects to prepare the field
	sd pointers;set pointers end
	sub pointers args
	div pointers 2
	add pointers :  #for null end

	#make a container
	sv pobjects%pobjects
	setcall pobjects# alloc(pointers)

	#set end
	sv objects;set objects pointers#
	set objects# (NULL)

	#sd remaining_size=0
	while args!=end
		#alloc
		setcall objects# alloc((object_alloc))

		sv object;set object objects#
		set object# (NULL)  #this is not like the first file, there is 1 more like this extra in get_file
		add objects :
		set objects# (NULL)

		chars o1=".rela.data";chars o2=".rela.text"
		const o1c^o1;const o2c^o2
		value oN%{o1c,o2c,NULL}
		datax nrs#object_nr_of_sections   #same as previous call
		#blank sections at ocomp?

		sv p=object_alloc_secs
		add p object

		setcall p#d^ get_offset(args)  #the ocomp with these sections from that creation time are still respected (32 bits)
		#add remaining_size p#d^

		add p (datasize)
		incst args

		sd file
		setcall p# get_file(args,#file,(ET_REL),#oN,object,#nrs)
		call fclose(file)
		setcall p# objs_align(p#)
		incst args
	endwhile
	#return remaining_size
endfunction

#stripped size
function get_offset(sd fname)
	sd file;setcall file fopen(fname,"rb")
	if file!=(NULL)
		#at the first 3 documentations there is no info about errno errors for fseek ftell
		#it is implementation specific, many judgements can be made
		call seek(file,0,(SEEK_END))
		sd off;setcall off ftell(file)
		if off!=-1
			sub off (2+8)  #knowing \r\n same as ounused that is not headering with src. and 8 is copy-paste
			call seeks(file,off)
			chars buf={0,0,0,0, 0,0,0,0, 0}
			call read(file,#buf,8) #copy-paste
			datax nr#1
			call sscanf(#buf,"%08x",#nr) #copy-paste
			return nr
		endif
		call erMessages("ftell error at",fname)
	endif
	call fError(fname)
endfunction

function objs_concat(sd pobjects,sd dest)    #,sd sz)
	#sd pdatabin%pdatabin;setcall pdatabin# alloc(sz)
	sd src;set src dest

	#skip first memtomem
	sv object=object_alloc_secs;add object pobjects#
	add dest object#d^
	add object (datasize)
	add src object#
	incst pobjects

	while pobjects#!=(NULL)
		set object (object_alloc_secs);add object pobjects#
		sd stripped;set stripped object#d^
		#we implement own memcpy here because right to left can break all
		call memtomem(dest,src,stripped)
		add dest stripped
		add object (datasize)
		add src object#
		incst pobjects
	endwhile
endfunction

function memtomem()
i3
endfunction

function objs_align(sd *sz)
#must import the align from ocomp
i3
endfunction
