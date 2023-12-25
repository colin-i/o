
#pointer
function command_start(sv p_is_comment,sv p_is_comment_multiline,sv p_cursor_start,sv p_content,sd last)
	set p_cursor_start# p_content#
	setcall p_content# mem_spaces(p_content#,last)
	set p_is_comment# 0
	set p_is_comment_multiline# 0
	ss pointer;set pointer p_content#
	if pointer!=last
		if pointer#=(commentascii)
			set p_is_comment# 1
			inc pointer
			if pointer!=last
				if pointer#=(asciiexclamationmark)
					set p_is_comment_multiline# 1
					inc pointer
				endif
			endif
		endif
	endif
	return pointer
endfunction
