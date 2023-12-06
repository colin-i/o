
format elfobj

orphan off #test

function inner()
ret
endfunction

entry main()
ret
override exit_end 1
ret
override exit_end 0 #test
ret
exit 2
