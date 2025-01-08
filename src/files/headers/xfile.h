
const Xfile_sz_char=1
const Xfile_sz_int=4

const Xfile_proto=0
const Xfile_comment=1
const Xfile_commentmulti=2
const Xfile_commentlineend=3
const Xfile_format=4
const Xfile_include=5
const Xfile_functiondef=6
const Xfile_declare=7
const Xfile_action=8
const Xfile_action2=9
const Xfile_call=10
const Xfile_callex=11
#Const ifinscribe=-1; #Const nocondnumber=-1; const elseinscribe_write=0; const elseinscribe_skip=1
const Xfile_if=12
const Xfile_elseif=13
const Xfile_else=14
const Xfile_while=15
const Xfile_whiletrue=16
const Xfile_break=17
const Xfile_continue=18
const Xfile_end=19
const Xfile_ret=20
const Xfile_library=21
const Xfile_import=22
const Xfile_aftercall=23
const Xfile_hex=24
const Xfile_override=25
const Xfile_orphan=26
const Xfile_interrupt=27
const Xfile_line=28
const Xfile_iend=29
#at the moment these are < 0x100

#t from type
const Xfile_function_tintern=0
const Xfile_function_traw=1
#const Xfile_function_not_x=Xfile_function_traw
const Xfile_function_extern=2
const Xfile_function_entry=3

const Xfile_function_t_normal=0
const Xfile_function_t_struct=1

const Xfile_function_e_normal=0
const Xfile_function_e_varargs=1

const Xfile_declfield_const=0
const Xfile_declfield_stack=1
const Xfile_declfield_data=2
const Xfile_declfield_varargs=3

const Xfile_declfield_const_normal=0
const Xfile_declfield_const_cond=1

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
#const Xfile_decltype_varargs=Xfile_decltype_const+1  #here will be used Xfile_declfield_varargs
#const Xfile_decltype_done=0xff

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

const Xfile_declmode_string_pop_no=0
const Xfile_declmode_string_pop_yes=1

const Xfile_declext_no=0
const Xfile_declext_yes=1

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

#!
Const asciiexclamationmark=0x21
Const asciidollar=0x24
Const asciipercent=0x25
Const asciiand=0x26
Const asciiast=0x2A
Const asciiplus=0x2B
Const asciiminus=0x2D
Const asciislash=0x2F
Const asciicolon=0x3A
Const asciiless=0x3C
Const asciiequal=0x3D
Const asciigreater=0x3E
Const asciiD=0x44
Const asciiE=0x45
Const asciiG=0x47
Const asciiL=0x4C
Const asciiR=0x52
Const asciiS=0x53
Const asciiU=0x55
Const asciiV=0x56
Const asciileftsquareBracket=0x5B
Const asciibs=0x5C
Const asciirightsquareBracket=0x5D
Const asciicirc=0x5E
Const asciia=0x61
Const asciie=0x65
Const asciig=0x67
Const asciil=0x6C
Const asciio=0x6F
Const asciip=0x70
Const asciiu=0x75
Const asciivbar=0x7C
Const asciirightcurlyBracket=0x7D
!

# ! $ % ^ & * - =+
# e uU o p [ ]}
# a gG lL : \|
# < > /
#Const unreadyNumber=0
const Xfile_numbers_operation_add=0x2B                    #parsed at spelling, asciiplus
const Xfile_numbers_operation_sub=0x2D                    #parsed at spelling, asciiminus
const Xfile_numbers_operation_mul=0x2A                    #parsed at spelling, asciiast
const Xfile_numbers_operation_div=0x2F                    #parsed at spelling, asciislash
const Xfile_numbers_operation_divu=0x5C                   # asciibs
const Xfile_numbers_operation_and=0x26                    #parsed at spelling, asciiand
const Xfile_numbers_operation_or=0x7C                     #parsed at spelling, asciivbar
const Xfile_numbers_operation_xor=0x5E                    #parsed at spelling, asciicirc
const Xfile_numbers_operation_pow=0x24                    #parsed at spelling, asciidollar
const Xfile_numbers_operation_rem=0x25                    #parsed at spelling, asciipercent
const Xfile_numbers_operation_remu=0x3A                   #asciicolon
const Xfile_numbers_operation_shl=0x5B                    # asciileftsquareBracket
const Xfile_numbers_operation_sar=0x5D                    # asciirightsquareBracket
const Xfile_numbers_operation_shr=0x7D  #const Xfile_numbers_last is Xfile_numbers_operation_shr #const Xfile_numbers_notmapped is 0xff # 0x7f DEL 0x7E ~ asciirightcurlyBracket is 0x7D
const Xfile_numbers_operation_equal=0x3D                  #parsed at spelling, asciiequal
const Xfile_numbers_operation_inequal=0x65                # asciie
const Xfile_numbers_operation_less=0x3C                   #parsed at spelling, asciiless
const Xfile_numbers_operation_greater=0x3E                #parsed at spelling, asciigreater
const Xfile_numbers_operation_lessequal=0x4C              # asciiL
const Xfile_numbers_operation_greaterequal=0x47           # asciiG
const Xfile_numbers_operation_logicaland=0x61             # asciia
const Xfile_numbers_operation_logicalor=0x6F              # asciio
const Xfile_numbers_operation_unsignedless=0x75           # asciiu
const Xfile_numbers_operation_unsignedgreater=0x55        # asciiU
const Xfile_numbers_operation_unsignedlessequal=0x6C      # asciil
const Xfile_numbers_operation_unsignedgreaterequal=0x67   # asciig
const Xfile_numbers_operation_parity=0x21                 #parsed at spelling, asciiexclamationmark
const Xfile_numbers_operation_odd=0x70                    # asciip

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
const Xfile_numbers_type_fsizeXX=9
#v from var
const Xfile_numbers_type_vsizeVar=10
const Xfile_numbers_type_voffsetVar=11

const Xfile_suffix_false=0
const Xfile_suffix_true=1
const Xfile_suffix_notasuffix=2       # hacky way to see a function fast, instead of searching through all functions
const Xfile_suffix_cast_none=0
const Xfile_suffix_cast_value=0x56    # asciiV
const Xfile_suffix_cast_data=0x44     # asciiD
const Xfile_suffix_cast_word=0x57     # asciiW
const Xfile_suffix_cast_string=0x53   # asciiS

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

const Xfile_action2_set=0x45  # asciiE
const Xfile_action2_add=0x2B  # asciiplus
const Xfile_action2_sub=0x2D  # asciiminus
const Xfile_action2_mult=0x2A # asciiast
const Xfile_action2_div=0x2F  # asciislash
const Xfile_action2_divu=0x44 # asciiD
const Xfile_action2_rem=0x25  # asciipercent
const Xfile_action2_remu=0x52 # asciiR
const Xfile_action2_and=0x26  # asciiand
const Xfile_action2_or=0x7C   # asciivbar
const Xfile_action2_xor=0x5E  # asciicirc

const Xfile_call_normal=0
const Xfile_call_ret=1

const Xfile_cond_greatequalunsign=0x82
# const Xfile_cond_first=Xfile_cond_greatequalunsign
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

const Xfile_proto_void=0
const Xfile_proto_long=1
