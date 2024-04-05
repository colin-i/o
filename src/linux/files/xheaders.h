



Const PATH_MAX=4096

Const flag_O_BINARY=0       #this on linux is not a flag
Const flag_MAX_PATH=PATH_MAX

Const flag_O_CREAT=0x0040
const S_IRWXU=0700
const S_IRUSR=0400;const S_IWUSR=0200
const S_IRGRP=0040;const S_IXGRP=0010
const S_IROTH=0004;const S_IXOTH=0001
Const exec_perms=S_IRWXU|S_IRGRP|S_IXGRP|S_IROTH|S_IXOTH
const nonexec_perms=S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH

Const F_OK=0
Const X_OK=1
