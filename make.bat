
::use makewin32
exit

md build
o.exe "src/windows/o.s"
move src\windows\o.exe build\
copy .ocompiler.txt build\