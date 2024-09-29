
OB = ounused

all: ${OB}

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

ver=version.h
vers=../${ver}
${vers}:
	$(MAKE) -f ../Makefile ${ver}

${FULLOBJO}: ${FULLOBJS} ../version.h
	${launcher} ${OCOMP} $< exit_end 1 ${OFLAGSEXTRA}

ATLDCOM = $(LD) ${linkerflags} -melf_i386 --dynamic-linker=/lib/ld-linux.so.2 -o $@ -lc -entry main

${OB}: ${OBJ}
	${ATLDCOM} ${FULLOBJO}
	${launcher} ./${OB} ${FULLOBJLOG}

install:
	$(MAKE) all
	$(MAKE) install-proj
install-proj:
	install -D ${OB} \
		$(DESTDIR)$(prefix)/bin/${OB}

clean-compile:
	-rm -f ${FULLOBJO}
	-rm -f ${FULLOBJLOG}
	-rm -f ${vers}

clean-link:
	-rm -f ${OB}

clean: clean-compile clean-link
distclean: clean

uninstall:
	-rm -f $(DESTDIR)$(prefix)/bin/${OB}

test:
	echo "Nothing"

.PHONY: all install install-proj clean clean-compile clean-link distclean uninstall test
