
vdata *=0

aftercall *test

function a()
	call b()
	call c()
endfunction

function b()
	call printf("test\n")
endfunction
function c()
	call printf("test2\n")
endfunction

entry main()
value ^e^a
#i3
call e()
aftercallactivate
call e()
aftercallclear
call e()
