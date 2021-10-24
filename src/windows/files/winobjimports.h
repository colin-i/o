


Import "_realloc" realloc
Import "_free" free
Import "_sprintf" sprintf
Import "_memcpy" memtomem
Import "_memset" memset
Import "_exit" exit

Import "__open" open
Import "__close" close
Import "__read" read
Import "__write" write
Import "__chdir" chdir
Import "__getcwd" getcwd

Import "__lseek" lseek
Import "_strcat" strcat

#kernel32
Import "_GetCommandLineA@0" GetCommandName
Import "_GetTickCount@0" GetTickCount
Import "_GetModuleFileNameA@12" GetModuleFileName

#user32
Import "_MessageBoxA@16" MessageBox

#comdlg32
Import "_GetOpenFileNameA@4" GetOpenFileName