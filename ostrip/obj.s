
const object_nr_of_sections=2
const object_allocs=2*:

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
		setcall objects# alloc((object_allocs))

		sv object;set object objects#
		set object# (NULL)  #this is not like the first file, there are 2 more like this extra in get_file

		chars o1=".rela.data";chars o2=".rela.text"
		const o1c^o1;const o2c^o2
		value oN%{o1c,o2c,NULL}
		datax nrs#object_nr_of_sections   #same as previous call
		sd file
		call get_file(args,#file,(ET_REL),#oN,#object,#nrs)
		call fclose(file)
		add args (2*:)
	endwhile
endfunction
