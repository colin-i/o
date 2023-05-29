
format elfobj64

importx "printf" printf

#data *#!!main  #!! error
data *#1;datax *#1;data *#1

function f1()
data *#1;datax *#2;data *#1
call printf("%u\n",(!!f1))    #8
datax *#1
endfunction

data *#1;datax *#3;data *#1

function f2()
data *#1;datax *#4;data *#1
call printf("%u\n",(!!f1))    #12
call printf("%u\n",(!!main))  #16
endfunction

data *#1;datax *#1;data a=!!main

entry main()
#const not_here=!!f1
call f1()
call f2()
call printf("%u\n",a)         #20
return 0
