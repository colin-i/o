
format elfobj64

importx "printf" printf

#data *#\main  #\ error
data *#1;datax *#1;data *#2

vstr p="%u\n"

function f1()
data *#1;datax *#2;data *#2
call printf(main.p,(\\f1))   #8
call printf(main.p,(\f1))    #12
data *#1;datax *#1
endfunction

data *#1;datax *#3;data *#2

function f2()
data *#1;datax *#4;data *#1
call printf(main.p,(\\f1))   #12
call printf(main.p,(\f1))    #16
call printf(main.p,(\\main)) #16
call printf(main.p,(\main))  #36
endfunction

data *#1;datax *#1

entry main()
#const not_here=\\f1         #same error
call f1()
call f2()

call printf(p,(\\main))        #20
call printf(p,(\main))        #40
return 0
