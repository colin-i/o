
format elfobj

const a=1
#               add sub mul div   rem   pow and or  xor shl  sar  shr     less greater neg not
char *examples={3+2,6-4,5*5,32/10,32%10,3$2,7&2,5|2,7^2,2<<2,8>>3,-1>>>25,2<3, 2>3,    -a, ~0}
#hex:           5   2   19  3     2     9   2   7   5   8    1    7f      1    0       ff  ff
