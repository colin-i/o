
const object_nr_of_sections=2
const section_alloc=:*section_nr_of_values
const object_alloc=object_nr_of_sections*section_alloc

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
		sd file
		#blank sections at ocomp?
		call get_file(args,#file,(ET_REL),#oN,object,#nrs)
		call fclose(file)
		add args (2*:)
	endwhile
endfunction

function iterate_simple() #sd voffset)
	sv pobjects%pobjects
	while pobjects#!=(NULL)
		incst pobjects
	endwhile
endfunction
