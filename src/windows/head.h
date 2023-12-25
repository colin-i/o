

#headers
Include "./files/winheaders.h"
Include "../files/headers.h"

#functions
include "./files/prefextra.oc"
Function Message(str text)
	Data null=NULL
	Call MessageBox(null,text,null,null)
EndFunction
include "./files/platform.oc"
Include "../files/functions.oc"
