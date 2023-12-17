
importx "fseek" fseek
importx "ftell" ftell
importx "rewind" rewind
importx "malloc" malloc
importx "fread" fread
importx "free" free

const SEEK_END=2

einclude "../src/files/headers/xfile.h" "/usr/include/ocompiler/xfile.h"
#einclude? will use all constants in the header. yes, but some are used without touching them, like in this next function
const Xfile_last_command=Xfile_line

function loop(sd input)
	sd a;set a fseek(input,0,(SEEK_END)) #on 32 can be -1 return error
	if a=0
		sd pointer;set pointer ftell(input) #is still same place if file deleted in parallel
		#if pointer!=-1  #lseek and same result (remark fileno)
		call rewind(input)
		ss buffer;set buffer malloc(pointer)
		if buffer!=(NULL)
			sd r;set r fread(buffer,pointer,1,input)
			if r=1
				add pointer buffer
				while buffer!=pointer
					charx command#1;call get_char(#buffer,#command)
					if command>(Xfile_last_command)
						break
					end
					value Xfile_comment^comment
					value *Xfile_commentmulti^commentmulti
					value *Xfile_commentlineend^commentlineend
					value *Xfile_format^format
					value *Xfile_include^include
					value *Xfile_functiondef^functiondef
					value *Xfile_declare^declare
					value *Xfile_action^action
					value *Xfile_action2^action2
					value *Xfile_call^call
					value *Xfile_callex^callex
					value *Xfile_if^if
					value *Xfile_else^else
					value *Xfile_while^while
					value *Xfile_break^break
					value *Xfile_continue^continue
					value *Xfile_end^end
					value *Xfile_ret^ret
					value *Xfile_library^library
					value *Xfile_import^import
					value *Xfile_aftercall^aftercall
					value *Xfile_hex^hex
					value *Xfile_override^override
					value *Xfile_orphan^orphan
					value *Xfile_interrupt^interrupt
					value *Xfile_line^line
					mult command :
					sv dest^Xfile_comment;add dest command
					call dest(#buffer)
				end
			end
			call free(buffer)
		end
	end
end

function get_char(sv pbuffer,ss pcommand)
	ss buffer;set buffer pbuffer#
	set pcommand# buffer#
	inc pbuffer#
end

function comment(sv *pbuffer)
end
function commentmulti(sv *pbuffer)
end
function commentlineend(sv *pbuffer)
end
function format(sv *pbuffer)
end
function include(sv *pbuffer)
end
function functiondef(sv *pbuffer)
end
function declare(sv *pbuffer)
end
function action(sv *pbuffer)
end
function action2(sv *pbuffer)
end
function call(sv *pbuffer)
end
function callex(sv *pbuffer)
end
function if(sv *pbuffer)
end
function else(sv *pbuffer)
end
function while(sv *pbuffer)
end
function break(sv *pbuffer)
end
function continue(sv *pbuffer)
end
function end(sv *pbuffer)
end
function ret(sv *pbuffer)
end
function library(sv *pbuffer)
end
function import(sv *pbuffer)
end
function aftercall(sv *pbuffer)
end
function hex(sv *pbuffer)
end
function override(sv *pbuffer)
end
function orphan(sv *pbuffer)
end
function interrupt(sv *pbuffer)
end
function line(sv *pbuffer)
end
