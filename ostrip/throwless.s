
function frees()
	valuex exefile#1
	const pexefile^exefile
	if exefile!=(NULL)
		call fclose(exefile)
	valuex exedata#1;valuex exedatasize#1
	valuex exetext#section_nr_of_values
	#valuex exesym#section_nr_of_values
	const pexedata^exedata;const pexedatasize^exedatasize
	const pexetext^exetext
	#const pexesym^exesym
		if exedata!=(NULL)
			call free(exedata)
			if exetext!=(NULL)
				call free(exetext)
			endif
		endif
		valuex objects#1
		const pobjects^objects
		if objects!=(NULL)
			call freeobjects(objects)
			call free(objects)
		endif
	endif
endfunction
function freeobjects(sv objects)
	while objects#!=(NULL)
		call freeobject(objects#)
		call free(objects#)
		add objects :
	endwhile
endfunction
function freeobject(sv object)
	sd end=object_alloc_secs
	add end object
	while object!=end
		if object#!=(NULL)
			call free(object#)
		else
			ret
		endelse
		add object (section_alloc)
	endwhile
endfunction

#file

#pos/-1
function shnames_find(ss mem,sd end,sd str)
	sd pos=0
	while mem!=end
		sd cmp;setcall cmp strcmp(mem,str)
		if cmp==0
			return pos
		endif
		addcall mem strlen(mem)
		inc mem
		inc pos
	endwhile
	return -1
endfunction

#obj

function objs_concat(sd objects,sv pdata)
	sd initial;set initial pdata#
	#sd pdatabin%pdatabin;setcall pdatabin# alloc(sz)
	sd dest;set dest initial
	sd src;set src dest

	#skip first memtomem
	sv object=object_alloc_secs;add object objects#
	add dest object#d^
	add object (datasize)
	addcall src objs_align(object#)
	incst objects

	while objects#!=(NULL)
		set object (object_alloc_secs);add object objects#
		sd stripped;set stripped object#d^
		#we implement own memcpy here because right to left can break all
		call memtomem(dest,src,stripped)
		add dest stripped
		add object (datasize)
		addcall src objs_align(object#)
		incst objects
	endwhile

	add pdata :
	#exe data size can have last object aligned/unaligned this way (don't count on initial size)
	sub dest initial
	set pdata# dest
endfunction

function memtomem(sv dest,sv src,sd size)
	#optimized?
	const stack_size_trail=:-1
	sd opt=~stack_size_trail
	and opt size
	sub size opt
	add opt dest
	while dest!=opt
		set dest# src#
		incst dest
		incst src
	endwhile
	add size dest
	while dest!=size
		set dest#s^ src#s^
		inc dest
		inc src
	endwhile
endfunction

function objs_align(sd sz)
#must import the align from ocomp
	add sz (elf_datasec_obj_align)
	const elf_datasec_obj_align_trail=elf_datasec_obj_align-1
	and sz (~elf_datasec_obj_align_trail)
	return sz
endfunction
