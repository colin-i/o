
Include "./head.h"

#gcc(i686/x86_64) will ask for WinMain, but it has argc,argv entry, there are some additional steps
#old remark: gcc want -8 at inplace instead of 0

#gcc:
#	int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR lpCmdLine, int nCmdShow)
#but lpCmdLine is a structure, the string is after some bytes

Entry _WinMain@16()
	Include "./text.s"
