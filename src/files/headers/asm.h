
#movers
Const tomod=0x40
Const toregopcode=8

#REX Prefix
const REX_default=2$6
const REX_W=2$3
const REX_R=2$2
#const REX_X=2$1
#const REX_B=2$0
const REX_Operand_64=REX_default|REX_W
const REX_R8_15=REX_default|REX_W|REX_R

#opcodes

Const retcom=0xc3
const intimm8=0xCD
const jmp_rel8=0xeb
const jnc_instruction=0x73

const atalimm=0xb0
const ateaximm=0xb8
Const atedximm=0xba
Const moveatmemtheproc=0x89
Const moveatprocthemem=0x8b
Const moveatregthemodrm=moveatprocthemem
const moveatprocthemem_sign=0x63
const mov_imm_to_rm=0xc7

const twobytesinstruction_byte1=0x0F
const bt_instruction=0xBA

#mod,reg/opcode,r/m

#mods
Const mod_0=0
Const disp8=1
Const disp32=2
Const RegReg=3

const disp8mod=disp8*tomod
#const disp32mod=disp32*tomod
const regregmod=RegReg*tomod

#regopcodes
#Const noregnumber=-1
Const eaxregnumber=0
Const ecxregnumber=1
Const edxregnumber=2
Const ebxregnumber=3
Const espregnumber=4
Const ebpregnumber=5
const disp32regnumber=5
Const esiregnumber=6
Const ediregnumber=7
Const ahregnumber=4
#Const regopcode_mask=0x7

#mixt
Const Notregopcode=2
#
const bt_reg_imm8=4*toregopcode|regregmod
