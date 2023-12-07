
format elfobj

const a=1
#               add sub mul div   rem   pow and or  xor shl1 sar1  shr1   less greater neg not
char *examples={3+2,6-4,5*5,32/10,32%10,3$2,7&2,5|2,7^2,2<<2,8>>3,-1>>>25,2<3, 2>3,    -a, ~0}
#hex:           5   2   19  3     2     9   2   7   5   8    1    7f      1    0       ff  ff

override w_as_e 0
data *overflows=2$30  #40.. div is signed inside, if there are problems udiv can be implemented
data *=2$31           #80   overflow
data *=2$32           #0    1 overflow message
data *=1<<31          #80..
data *=1<<32          #0    overflow
data *=0<<1111        #0    direct
data *=0x80000000>>31 #ff..
data *=0x80000000>>32 #ff.. direct
data *=0x40000000>>31 #0    direct
data *=0x80000000>>>31#1
data *=0x80000000>>>32#0    direct
data *=0xffFFffFE+1   #ff
data *=0xffFFffFE+2   #0    overflow
data *=0x20000000*2   #40   same as 2 pow 30
data *=0x20000000*4   #80   overflow
