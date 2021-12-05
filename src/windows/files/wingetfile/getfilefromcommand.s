

sd command_name
sd commname_size

SetCall command_name GetCommandName()

#this is so bugged but accepted , strlen is ansi, but no wide path in this program, so first XX00h will stop
SetCall commname_size strlen(command_name)
If commname_size!=zero
	setcall argv CommandLineToArgvW(command_name,#argc)
	if argv!=(NULL)
		if argc>1
			sd mirror
			set mirror argv;incst mirror
			sd aux_mirror;set aux_mirror mirror#
			call wide_to_ansi(aux_mirror)
			sd size_of_pathin
			setcall size_of_pathin strlen(aux_mirror)
			If size_of_pathin!=zero
				If size_of_pathin<=(flag_MAX_PATH-1)
					inc size_of_pathin
					Call memtomem(path,aux_mirror,size_of_pathin)
				EndIf
			EndIf
			#if argc>2
			#	incst mirror
			#	call wide_to_ansi(mirror#)
			#endif
		endif
	endif
EndIf