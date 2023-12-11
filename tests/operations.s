
format elfobj

const a=1
#               add sub mul div   divu           rem   remu     pow and or  xor not shl1 sar1  shr1   equal inequal less greater unsignedLess  unsignedGreater parity odd  neg
char *examples={3+2,6-4,5*5,32/10,-1//0x10000000,32%10,-1%%0x10,3$2,7&2,5|2,7^2,~0, 2<<2,8>>3,-1>>>25,7=7,  7!=7,   2<3, 2>3,    1<^0xffFFffFF,1>^0xffFFffFF,  4!1,   2!!1,-a}
#hex:           5   2   19  3     f              2     f        9     2 7   5   ff  8    1     7f     1     0       1    0       1             0               1      1    ff

override w_as_e 0
data *overflows=2$31  #80..
data *=2$32           #0    overflow
data *=2$33           #0    1 overflow message
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
data *=0x40000000*2   #80
data *=0x40000000*4   #00   overflow
