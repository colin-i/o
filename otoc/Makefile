
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

#OFLAGS=

#problems at box64 and CC
ifeq (${conv_64},0)
#ATCCCOM = $(CC) ${linkerflags} -o ${prog}
ATLDCOM = $(LD) --dynamic-linker=/lib64/ld-linux-x86-64.so.2 ${linkerflags} ${L} -lc -entry main -o ${prog}
else
#ATCCCOM = $(CC) -m32 ${linkerflags} -o ${prog}
ATLDCOM = $(LD) -melf_i386 --dynamic-linker=/lib/ld-linux.so.2 ${linkerflags} ${L} -lc -entry main -o ${prog}
OFLAGS+=conv_64 1
endif

OFLAGS+=${OFLAGSEXTRA}

#uncomment this to not see ->     make: Circular otoc.oc.o <- otoc.oc dependency dropped.
#${FULLOBJS}:
#	echo something or will not work

%.o: ${FULLOBJS}
	${OCOMP} $< ${OFLAGS}

${prog}: ${OBJ}
	${OLINK} ${FULLOBJLOG}
	@echo
	#${ATCCCOM} ${FULLOBJO}
	${ATLDCOM} ${FULLOBJO}

install: all
	install -D ${prog} \
		$(DESTDIR)$(prefix)/bin/${prog}

clean:
	-rm -f ${FULLOBJO}
	-rm -f ${FULLOBJLOG}
	-rm -f ${prog}
distclean: clean

uninstall:
	-rm -f $(DESTDIR)$(prefix)/bin/${prog}

test:
	echo "Nothing"

.PHONY: all install clean distclean uninstall test
