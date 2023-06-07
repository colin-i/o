
format elfobj64

importx "printf" printf

entry main()

char a=1
data b=2
value c=3
vdata d=1
vstr e=1

sv f=1

char g#66123

charx aa#2
datax bb#3
valuex cc#4

call printf("%d\n",(!main.a))  #1
call printf("%d\n",(!main.b))  #4
call printf("%d\n",(!main.c))  #8
call printf("%d\n",(!main.c#)) #8
call printf("%d\n",(!main.d#)) #4
call printf("%d\n",(!main.e#)) #1

call printf("%d\n",(!main.f))  #8
call printf("%d\n",(!main.f#)) #8

call printf("%d\n",(!main.aa)) #2
call printf("%d\n",(!main.bb)) #12
call printf("%d\n",(!main.cc)) #32

#return (!main.g)    #error
return 0
