
format elfobj64

function file()
      valuex path#1
      valuex lines#1
endfunction

entry main()
value test#1;value test2#1
sv aux^test

set aux#:file.path 2
set aux#:file.lines 3

add test test2
return test
