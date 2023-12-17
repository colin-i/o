
function functiondef_intern(sv pbuffer)
	datax args#1;call get_data(pbuffer,#args)
end
#function functiondef_raw(sv pbuffer)
function functiondef_extern(sv pbuffer)
	charx e#1;call get_char(pbuffer,#e)
	call functiondef_intern(pbuffer)
end
#function functiondef_entry(sv pbuffer)
