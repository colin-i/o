
format elfobj64

function b()
data a#1
endfunction

entry main()

vstr a="qwer"

return 2
inc #a
incst a
dec a
decst a
neg a
not a
shl a
shr a
sar a
exit 3
return "asdf"
return a:b.a
return main.a#:b.a
