
prog=otoc

all: ${prog}

ifndef linkerflags
linkerflags=-O3 -s
endif
ifndef OCOMP
OCOMP=../src/o
endif
ifndef OLINK
OLINK=../ounused/ounused
endif
ifndef conv_64
conv_64=0
endif

OBJ = ${prog}.o
FULLOBJ = ./${prog}
FULLOBJS = ${FULLOBJ}.oc
FULLOBJO = ${FULLOBJ}.o
FULLOBJLOG = ${FULLOBJS}.log


ifndef ldprefer
	OFLAGSPRE= include_sec 1
endif

#problems at box64 and CC
ifeq (${conv_64},0)
	ATCCCOM = $(CC) ${linkerflags} -o
	ATLDCOM = $(LD) --dynamic-linker=/lib64/ld-linux-x86-64.so.2 ${linkerflags} ${L} -l:libc.so.6 -entry main -o
	#same like ostrip for libc.so.6
else
	ATCCCOM = $(CC) -m32 ${linkerflags} -o
	ATLDCOM = $(LD) -melf_i386 --dynamic-linker=/lib/ld-linux.so.2 ${linkerflags} ${L} -lc -entry main -o
	OFLAGSPRE+= conv_64 1
endif

ifndef OFLAGS
	OFLAGS= ${OFLAGSPRE}
endif
OFLAGS+= ${OFLAGSEXTRA}

number=number.h

number.pre.o: number.pre.oc
	${OCOMP} $< ${OFLAGS}
number.pre: number.pre.o
	if [ -z "${ldprefer}" ]; then \
		${ATCCCOM} $@ $^; \
	else \
		${ATLDCOM} $@ $^; \
	fi
${number}: number.pre
	${launcher} ./$<
#       in case otoc.oc is modified
${OBJ}: ${FULLOBJS} ${number}
	${OCOMP} $< ${OFLAGS}
${prog}: ${OBJ}
	${OLINK} ${FULLOBJLOG}
	if [ -z "${ldprefer}" ]; then \
		${ATCCCOM} ${prog} ${FULLOBJO}; \
	else \
		${ATLDCOM} ${prog} ${FULLOBJO}; \
	fi

install:
	$(MAKE) all
	$(MAKE) install-proj
install-proj:
	install -D ${prog} $(DESTDIR)$(prefix)/bin/${prog}
	#if [ "${NOOCONV}" != "1" ]; then install -D ${prog} $(DESTDIR)$(prefix)/bin/${prog} && echo ${prog} is installed; else echo ${prog} is not installed; fi
	#is at debian/ocompiler.install , will install here but not in the final deb

clean:
	-rm -f ${FULLOBJO}
	-rm -f ${FULLOBJLOG}
	-rm -f ${prog}
	-rm -f ${number}
	-rm -f number.pre
	-rm -f number.pre.o
	-rm -f number.pre.oc.log
distclean: clean

uninstall:
	-rm -f $(DESTDIR)$(prefix)/bin/${prog}

test:
	echo "Nothing"

.PHONY: all install install-proj clean distclean uninstall test
