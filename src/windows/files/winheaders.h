


Const flag_O_BINARY=0x8000
Const flag_MAX_PATH=260

Const flag_O_CREAT=0x0100
const _S_IREAD=0x100;const _S_IWRITE=0x80
const exec_perms=_S_IREAD|_S_IWRITE
const nonexec_perms=exec_perms

data argv#1
const p_argv^argv
data argc#1

str path_free#1
const p_path_free^path_free
