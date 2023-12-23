
format elfobj64

const EXIT_SUCCESS=0
const EXIT_FAILURE=1
const NULL=0

Const asciinul=0x0
Const asciidot=0x2E
Const asciic=0x63

importx "puts" puts
importx "fopen" fopen
importx "fclose" fclose
importx "strrchr" strrchr

include "loop.s"

function out_file(sd in)
	ss p;set p strrchr(in,(asciidot))
	if p!=(NULL)
		set p# 0
		set p strrchr(in,(asciidot))
		if p!=(NULL)
			#here we know there at at least two dots and of course the term null char
			inc p
			set p# (asciic)
			inc p
			set p# (asciinul)
			sd f;set f fopen(in,"wb")
			if f!=(NULL)
				return f
			end
			call puts("Cannot open output file")
		end
	end
	return (NULL)
end

entry main(sd argc,sv argv)
	if argc=2
		incst argv
		sd s;set s argv#
		sd f;setcall f fopen(s,"rb")
		if f!=(NULL)
			sd out;set out out_file(s)
			sd exit=EXIT_SUCCESS
			if out!=(NULL)
				set exit loop(f,out)
				call fclose(out)
			else
				set exit (EXIT_FAILURE)
			end
			call fclose(f)
			return exit
		end
		call puts("Cannot open input file")
		return (EXIT_FAILURE)
	end
	call puts("Usage: otoc filePath")
	return (EXIT_FAILURE)
