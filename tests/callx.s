
format elfobj64

value a#1
function b()
endfunction

entry main()
hex 144;call a(1)
hex 144;call b(1)
hex 144;callx a(1)
hex 144;callx b(1)
i3
