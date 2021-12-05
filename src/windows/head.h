

#headers
Include "./files/winheaders.h"
Include "../files/headers.h"

#functions
include "./files/prefextra.s"
Function Message(str text)
	Data null=NULL
	Call MessageBox(null,text,null,null)
EndFunction
include "./files/platform.s"
Include "../files/functions.s"
