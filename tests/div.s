
format elfobj64

char a#1
data b#1
value c#1

entry main()

hex 144,144,144,144//1
div a a
hex 144,144,144,144%%999
div b b
hex 144,144,144,144
div c c

hex 144,144,144,144
divu a a
hex 144,144,144,144
divu b b
hex 144,144,144,144
divu c c
