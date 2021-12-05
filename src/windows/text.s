

#main

set argv (NULL)
set path_free (NULL)

Include "../files/inits.s"

Data openfilenamemethod#1
Set openfilenamemethod false
Include "./files/wingetfile.s"

if argv!=(NULL)
	Include "../files/inits/conv.s"
endif

Include "../files/actions.s"

Include "./files/winend.s"

Call exit(zero)
