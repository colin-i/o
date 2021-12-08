
function conv_inits(sd argc,sd argv)
	if argc>2
		if argc==3
			sd convention_input
			set convention_input argv;add convention_input (2*:)
			ss argv2
			set argv2 convention_input#
			set convention_input argv2#
			if convention_input!=0
				if convention_input<(asciizero)
					inc argv2
					if argv2#==0
						sub convention_input (asciizero)
						if convention_input<=(last_convention_input)
							sd p
							setcall p p_neg_is_for_64()
							set p# convention_input
						endif
						return "argv2 must be 0,1 or 2"
					endif
					return "argv2 must have only one digit"
				endif
				return "argv2 is not a number"
			endif
			return "argv2 null"
		endif
		return "Too many arguments"
	endif
	return (noerror)
endfunction
