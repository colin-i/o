
const Xfile_comment=0
const Xfile_multicomment=1
const Xfile_functiondef=2
const Xfile_declare=3
const Xfile_action=4

#t from type
const Xfile_function_tintern=0
const Xfile_function_traw=1
#const Xfile_function_not_x=Xfile_function_traw
const Xfile_function_extern=2
const Xfile_function_entry=3

const Xfile_function_e_normal=0
const Xfile_function_e_varargs=1

const Xfile_declfield_const=0
const Xfile_declfield_stack=1
const Xfile_declfield_data=2

const Xfile_declfield_data_concrete=0
const Xfile_declfield_data_expand=1

const Xfile_decltype_byte=0
const Xfile_decltype_int=1
const Xfile_decltype_intByte=2
const Xfile_decltype_long=3
const Xfile_decltype_longInt=4
const Xfile_decltype_longByte=5
#const Xfile_decltype_const=Xfile_decltype_longByte+1

const Xfile_declfeature_normal=0
const Xfile_declfeature_unref=1
const Xfile_declfeature_throwless=2

const Xfile_declsign_pointer=0
const Xfile_declsign_reserve=1
const Xfile_declsign_equal=2
const Xfile_declsign_reloc=3
const Xfile_declsign_relocx=4

const Xfile_declmode_value=0
const Xfile_declmode_group=1
const Xfile_declmode_string=2

const Xfile_numbers_parenthesis_open=0
const Xfile_numbers_parenthesis_close=1
const Xfile_numbers_done=2

const Xfile_numbers_operation_add=asciiplus
const Xfile_numbers_operation_sub=asciiminus
const Xfile_numbers_operation_mul=asciiast
const Xfile_numbers_operation_div=asciislash
const Xfile_numbers_operation_and=asciiand
const Xfile_numbers_operation_or=asciivbar
const Xfile_numbers_operation_xor=asciicirc
const Xfile_numbers_operation_pow=asciidollar
const Xfile_numbers_operation_rem=asciipercent
const Xfile_numbers_operation_less=asciiless
const Xfile_numbers_operation_greater=asciigreater
const Xfile_numbers_operation_shl=asciicomma
const Xfile_numbers_operation_sar=asciidot

#here is ORing
const Xfile_numbers_prefix_none=0x0
const Xfile_numbers_prefix_neg=0x1
const Xfile_numbers_prefix_not=0x2

#i from int
const Xfile_numbers_type_ilong=0
const Xfile_numbers_type_idata=1
const Xfile_numbers_type_idatax=2
#t from text
const Xfile_numbers_type_tdecimal=3
const Xfile_numbers_type_thex=4
const Xfile_numbers_type_tconstant=5
#f from function
const Xfile_numbers_type_fsize=6
const Xfile_numbers_type_fsizeX=7
const Xfile_numbers_type_sizeVar=8
const Xfile_numbers_type_offsetVar=9

const Xfile_suffix_true=1
const Xfile_suffix_false=0
const Xfile_suffix_cast_none=0
const Xfile_suffix_cast_value=asciiV
const Xfile_suffix_cast_data=asciiD
const Xfile_suffix_cast_string=asciiS

#a from any
const Xfile_action_areturn=0
const Xfile_action_aexit=1
const Xfile_action_inc=2
const Xfile_action_incst=3
const Xfile_action_dec=4
const Xfile_action_decst=5
const Xfile_action_neg=6
const Xfile_action_not=7
const Xfile_action_shl=8
const Xfile_action_shr=9
const Xfile_action_sar=10

const Xfile_arg_number=0
const Xfile_arg_string=1
