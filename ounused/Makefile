all: ounused

OB = ounused
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
	${OCOMP} $< exit_end 1

ATLDCOM = $(LD) ${linkerflags} -melf_i386 --dynamic-linker=/lib/ld-linux.so.2 -o $@ -lc -entry main

ounused: ${OBJ}
	${ATLDCOM} ${FULLOBJO}
	./${OB} ${FULLOBJLOG}
	@echo

install: all
	install -D ounused \
		$(DESTDIR)$(prefix)/bin/ounused

clean-compile:
	-rm -f ${FULLOBJO}
	-rm -f ${FULLOBJLOG}

clean-link:
	-rm -f ounused

clean: clean-compile clean-link
distclean: clean

uninstall:
	-rm -f $(DESTDIR)$(prefix)/bin/ounused

test:
	echo "Nothing"

.PHONY: all install clean distclean uninstall test
