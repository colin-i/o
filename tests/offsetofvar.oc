
format elfobj64

data *#7
data b#1

function a()
data *#3
data b#1
datax *#5
datax c#1
sd *
sd d
endfunction

entry main()

importx "printf" printf

vstr info="%d\n"

call printf(info,(\a.b\))    #12
call printf(info,(\a.c\))    #20
call printf(info,(\a.d\))    #8
call printf(info,(\main.b\)) #28

return 0
