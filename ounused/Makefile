
OB = ounused

all: ${OB}

OBJ = ${OB}.o
FULLOBJ = ./${OB}
FULLOBJS = ${FULLOBJ}.s
FULLOBJO = ${FULLOBJ}.o
FULLOBJLOG = ${FULLOBJS}.log

ifndef OCOMP
OCOMP=../src/o
endif

ifndef linkerflags
linkerflags=-O1 -s
endif

%.o: ${FULLOBJS}
	${OCOMP} $< exit_end 1 ${OFLAGSEXTRA}

ATLDCOM = $(LD) ${linkerflags} -melf_i386 --dynamic-linker=/lib/ld-linux.so.2 -o $@ -lc -entry main

${OB}: ${OBJ}
	${ATLDCOM} ${FULLOBJO}
	./${OB} ${FULLOBJLOG}
	@echo

install: all
	install -D ${OB} \
		$(DESTDIR)$(prefix)/bin/${OB}

clean-compile:
	-rm -f ${FULLOBJO}
	-rm -f ${FULLOBJLOG}

clean-link:
	-rm -f ${OB}

clean: clean-compile clean-link
distclean: clean

uninstall:
	-rm -f $(DESTDIR)$(prefix)/bin/${OB}

test:
	echo "Nothing"

.PHONY: all install clean distclean uninstall test
