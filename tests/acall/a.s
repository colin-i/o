
vdata *=0

#aftercall test
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
aftercallenable
call e()
aftercalldisable
call e()
