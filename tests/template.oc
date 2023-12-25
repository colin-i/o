
format elfobj64

valuex x#1
valuex y#1

function file()
	valuex path#1
	valuex lines#1
	datax a#1
endfunction

function line()
	datax a#1
endfunction

entry main(sd *,sd c)
sd *#1
sd n#1
sd nn#1
value *=0x77
value test#1;value test2#1;data a#1
sv aux^test
value auxdata^test

set test:file.a 4
set test:line.a 4

set n:main.n 4
add n:main.c 4

set test:main.y 4
add test:y 4
add test:main.test 4
add test:test 4

#not this right now
#set aux#:file.a 4
set auxdata#:file.a 4

set aux#:file.path 2
add aux#:file.lines 2
add test test2
add test nn
return test    ##28
