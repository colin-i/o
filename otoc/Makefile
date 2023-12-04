
prog=otoc

all: ${prog}

ifndef linkerflags
linkerflags=-O1 -s
endif
ifndef OCOMP
OCOMP=../src/o
endif
ifndef OUNUSED
OUNUSED=../ounused/ounused
endif

OBJ = ${prog}.o
FULLOBJ = ./${prog}
FULLOBJS = ${FULLOBJ}.s
FULLOBJO = ${FULLOBJ}.o
FULLOBJLOG = ${FULLOBJS}.log
#OFLAGS=

%.o: ${FULLOBJS}
	${OCOMP} $< ${OFLAGS}

ATCCCOM = $(CC) ${linkerflags} -o ${prog}

${prog}: ${OBJ}
	${OUNUSED} ${FULLOBJLOG}
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
