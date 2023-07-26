
Include "./head.h"

#i686-w64-mingw32-gcc has main(argc,argv) but gcc want -8 at inplace instead of 0

#gcc:
#	int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR lpCmdLine, int nCmdShow)
#but lpCmdLine is a structure, the string is after some bytes

Entry _WinMain@16()
	Include "./text.s"
