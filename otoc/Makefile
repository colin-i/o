
prog=otoc

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
ifndef prefix
prefix=/usr
endif

OBJ = ${prog}.o
FULLOBJ = ./${prog}
FULLOBJS = ${FULLOBJ}.oc
FULLOBJO = ${FULLOBJ}.o
FULLOBJLOG = ${FULLOBJS}.log

number=number.oh
tags=tags.oh


ifneq (${platform},win)

ifeq (${conv_64},0)
	ATCCCOM = $(CC) ${linkerflags} -o
	ATLDCOM = $(LD) --dynamic-linker=/lib64/ld-linux-x86-64.so.2 ${linkerflags} ${L} -l:libc.so.6 -entry main -o
	#same like ostrip for libc.so.6
else
	ATCCCOM = $(CC) -m32 ${linkerflags} -o
	ATLDCOM = $(LD) -melf_i386 --dynamic-linker=/lib/ld-linux.so.2 ${linkerflags} ${L} -lc -entry main -o
endif
fullprog=${prog}
all: ${fullprog}

else

#OFLAGSPRE+= conv_64 2 #this is only when using linux ocomp
ATCCCOM = x86_64-w64-mingw32-gcc -o
fullprog=${prog}.exe
all: ${fullprog}

endif


ifeq (${conv_64},1)
	OFLAGSPRE+= conv_64 1
endif
OFLAGS=${OFLAGSPRE} ${OFLAGSEXTRA}

%.pre.o: %.pre.oc
	${OCOMP} $< ${OFLAGS}
	${OLINK} $<.log
%.pre: %.pre.o
	if [ -z "${ldprefer}" ]; then \
		${ATCCCOM} $@ $^; \
	else \
		${ATLDCOM} $@ $^; \
	fi
%.oh: %.pre
	${launcher} ./$<

${OBJ}: ${FULLOBJS} ${tags} ${number}
	${OCOMP} $< ${OFLAGS}
${fullprog}: ${OBJ}
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
	-rm -f ${fullprog}
	-rm -f ${number} number.pre number.pre.o number.pre.oc.log
	-rm -f ${tags} tags.pre tags.pre.o tags.pre.oc.log
distclean: clean

uninstall:
	-rm -f $(DESTDIR)$(prefix)/bin/${prog}

test:
	echo "Nothing"

.PHONY: all install install-proj clean distclean uninstall test
