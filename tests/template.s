
format elfobj64

function file()
	valuex path#1
	valuex lines#1
	datax a#1
endfunction

entry main()
value test#1;value test2#1;data a#1
sv aux^test
value auxdata^test

set aux#:file.path 2
set aux#:file.lines 3

set test:file.a 4

#not this right now
#set aux#:file.a 4
set auxdata#:file.a 4

add test test2
return test
