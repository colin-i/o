
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
FULLOBJS = ${FULLOBJ}.s
FULLOBJO = ${FULLOBJ}.o
FULLOBJLOG = ${FULLOBJS}.log

ifeq (${conv_64},0)
ATCCCOM = $(CC) ${linkerflags} -o ${prog}
else
ATCCCOM = $(CC) -m32 ${linkerflags} -o ${prog}
OFLAGS=conv_64 1
endif

OFLAGS+=${OFLAGSEXTRA}

%.o: ${FULLOBJS}
	${OCOMP} $< ${OFLAGS}

${prog}: ${OBJ}
	${OLINK} ${FULLOBJLOG}
	@echo
	${ATCCCOM} ${FULLOBJO}

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
