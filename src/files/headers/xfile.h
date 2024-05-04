
const Xfile_sz_char=1
const Xfile_sz_int=4

Include "./xfileascii.h"

const Xfile_comment=0
const Xfile_commentmulti=1
const Xfile_commentlineend=2
const Xfile_format=3
const Xfile_include=4
const Xfile_functiondef=5
const Xfile_declare=6
const Xfile_action=7
const Xfile_action2=8
const Xfile_call=9
const Xfile_callex=10
#Const ifinscribe=-1; #Const nocondnumber=-1; const elseinscribe_write=0; const elseinscribe_skip=1
const Xfile_if=11
const Xfile_else=12
const Xfile_while=13
const Xfile_whiletrue=14
const Xfile_break=15
const Xfile_continue=16
const Xfile_end=17
const Xfile_ret=18
const Xfile_library=19
const Xfile_import=20
const Xfile_aftercall=21
const Xfile_hex=22
const Xfile_override=23
const Xfile_orphan=24
const Xfile_interrupt=25
const Xfile_line=26
#at the moment these are <= 0xff

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
const Xfile_decltype_word=1
const Xfile_decltype_int=2
const Xfile_decltype_intByte=3
const Xfile_decltype_long=4
const Xfile_decltype_longByte=5
const Xfile_decltype_longWord=6
const Xfile_decltype_longInt=7
#const Xfile_decltype_const=Xfile_decltype_longInt+1  #here will be used Xfile_declfield_const

const Xfile_declfeature_normal=0
const Xfile_declfeature_unref=1
const Xfile_declfeature_throwless=2

const Xfile_declsign_pointer=0
const Xfile_declsign_reserve=1
const Xfile_declsign_equal=2
const Xfile_declsign_ereloc=3
const Xfile_declsign_erelocx=4

const Xfile_declmode_value=0
const Xfile_declmode_group=1
const Xfile_declmode_string=2

#here is ORing (~-N)
const Xfile_numbers_prefix_none=0x0
const Xfile_numbers_prefix_neg=0x1
const Xfile_numbers_prefix_not=0x2 # is ~(0x7E), attention at Xfile_numbers_last
#const Xfile_numbers_prefix_notneg=Xfile_numbers_prefix_not|Xfile_numbers_prefix_neg
#0x4 is free, 0x8
const Xfile_numbers_parenthesis_open=0x10
const Xfile_numbers_parenthesis_close=0x18
const Xfile_numbers_done=0x1f
# ! is 33(0x21 0x20 is space) is an operation

# ! $ % ^ & * - =+
# e uU o p [ ]}
# a gG lL : \|
# < > /
#Const unreadyNumber=0
const Xfile_numbers_operation_add=asciiplus               #parsed at spelling
const Xfile_numbers_operation_sub=asciiminus              #parsed at spelling
const Xfile_numbers_operation_mul=asciiast                #parsed at spelling
const Xfile_numbers_operation_div=asciislash              #parsed at spelling
const Xfile_numbers_operation_divu=asciibs
const Xfile_numbers_operation_and=asciiand                #parsed at spelling
const Xfile_numbers_operation_or=asciivbar                #parsed at spelling
const Xfile_numbers_operation_xor=asciicirc               #parsed at spelling
const Xfile_numbers_operation_pow=asciidollar             #parsed at spelling
const Xfile_numbers_operation_rem=asciipercent            #parsed at spelling
const Xfile_numbers_operation_remu=asciicolon
const Xfile_numbers_operation_shl=asciileftsquareBracket
const Xfile_numbers_operation_sar=asciirightsquareBracket
const Xfile_numbers_operation_shr=asciirightcurlyBracket  #const Xfile_numbers_last is Xfile_numbers_operation_shr #const Xfile_numbers_notmapped is 0xff # 0x7f DEL 0x7E ~ this is 0x7D
const Xfile_numbers_operation_equal=asciiequal            #parsed at spelling
const Xfile_numbers_operation_inequal=asciie
const Xfile_numbers_operation_less=asciiless              #parsed at spelling
const Xfile_numbers_operation_greater=asciigreater        #parsed at spelling
const Xfile_numbers_operation_lessequal=asciiL
const Xfile_numbers_operation_greaterequal=asciiG
const Xfile_numbers_operation_logicaland=asciia
const Xfile_numbers_operation_logicalor=asciio
const Xfile_numbers_operation_unsignedless=asciiu
const Xfile_numbers_operation_unsignedgreater=asciiU
const Xfile_numbers_operation_unsignedlessequal=asciil
const Xfile_numbers_operation_unsignedgreaterequal=asciig
const Xfile_numbers_operation_parity=asciiexclamationmark #parsed at spelling
const Xfile_numbers_operation_odd=asciip

#i from int
const Xfile_numbers_type_ilong=0
const Xfile_numbers_type_idata=1
const Xfile_numbers_type_idatax=2
#t from text
const Xfile_numbers_type_tdecimal=3
const Xfile_numbers_type_toctal=4
const Xfile_numbers_type_thexadec=5
const Xfile_numbers_type_tconstant=6
#f from function
const Xfile_numbers_type_fsize=7
const Xfile_numbers_type_fsizeX=8
#v from var
const Xfile_numbers_type_vsizeVar=9
const Xfile_numbers_type_voffsetVar=10

const Xfile_suffix_false=0
const Xfile_suffix_true=1
const Xfile_suffix_notasuffix=2       # hacky way to see a function fast, instead of searching through all functions
const Xfile_suffix_cast_none=0
const Xfile_suffix_cast_value=asciiV
const Xfile_suffix_cast_data=asciiD
const Xfile_suffix_cast_string=asciiS

#a from any, t from type
const Xfile_action_areturn=0
const Xfile_action_aexit=1
const Xfile_action_tinc=2
const Xfile_action_tincst=3
const Xfile_action_tdec=4
const Xfile_action_tdecst=5
const Xfile_action_tneg=6
const Xfile_action_tnot=7
const Xfile_action_tbase=8
const Xfile_action_tleave=9
const Xfile_action_tshl1=10
const Xfile_action_tshr1=11
const Xfile_action_tsar1=12

const Xfile_arg_number=0
const Xfile_arg_string=1
const Xfile_arg_varfn=2
const Xfile_arg_call=3

const Xfile_arg_varfn_prefix_no=0
const Xfile_arg_varfn_prefix_yes=1
const Xfile_arg_varfn_colon_no=0
const Xfile_arg_varfn_colon_yes=1
const Xfile_arg_varfn_dot_no=0
const Xfile_arg_varfn_dot_yes=1

#same ORing [x][g]
const Xfile_arg_call_normal=0x
const Xfile_arg_call_extern=0x1
const Xfile_arg_call_skipaftercall=0x2

const Xfile_action2_set=0
const Xfile_action2_add=1
const Xfile_action2_sub=2
const Xfile_action2_mult=3
const Xfile_action2_div=4
const Xfile_action2_divu=5
const Xfile_action2_rem=6
const Xfile_action2_remu=7
const Xfile_action2_and=8
const Xfile_action2_or=9
const Xfile_action2_xor=10

const Xfile_call_normal=0
const Xfile_call_ret=1

const Xfile_cond_greatequalunsign=0x82
const Xfile_cond_lessunsign=0x83
const Xfile_cond_notequal=0x84
const Xfile_cond_equal=0x85
const Xfile_cond_greatunsign=0x86
const Xfile_cond_lessequalunsign=0x87
const Xfile_cond_notparity=0x8A
const Xfile_cond_parity=0x8B
const Xfile_cond_greatequal=0x8C
const Xfile_cond_less=0x8D
const Xfile_cond_great=0x8E
const Xfile_cond_lessequal=0x8F

const Xfile_format_exe=0
const Xfile_format_elf=1
const Xfile_format_elfobj=2
const Xfile_format_elfobj64=3
const Xfile_format_elfobjig=4
const Xfile_format_elfobj64ig=5

const Xfile_include_normal=0
const Xfile_include_extern=1

const Xfile_include_alternative_no=0
const Xfile_include_alternative_yes=1

const Xfile_aftercall_declare=0
const Xfile_aftercall_import=1
#const Xfile_aftercall_declarative=Xfile_aftercall_import # less or equal
const Xfile_aftercall_enable=2
const Xfile_aftercall_disable=3

const Xfile_import_normal=0
const Xfile_import_extern=1

const Xfile_orphan_no=0
const Xfile_orphan_yes=1
