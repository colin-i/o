
OB = ounused

../version.h:
	$(MAKE) -f ../Makefile version.h
all: ../version.h ${OB}

OBJ = ${OB}.o
FULLOBJ = ./${OB}
FULLOBJS = ${FULLOBJ}.oc
FULLOBJO = ${FULLOBJ}.o
FULLOBJLOG = ${FULLOBJS}.log

ifndef OCOMP
OCOMP=../src/o
endif

ifndef linkerflags
linkerflags=-O3 -s
#             1
endif

${FULLOBJO}: ${FULLOBJS}
	${launcher} ${OCOMP} $< exit_end 1 ${OFLAGSEXTRA}

ATLDCOM = $(LD) ${linkerflags} -melf_i386 --dynamic-linker=/lib/ld-linux.so.2 -o $@ -lc -entry main

${OB}: ${OBJ}
	${ATLDCOM} ${FULLOBJO}
	${launcher} ./${OB} ${FULLOBJLOG}

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
#for ../version.h first
.NOTPARALLEL:
