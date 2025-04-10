
OB = ostrip

all: ${OB}

ifndef nobits_virtual
nobits_virtual=1
endif

ifndef linkerflags
linkerflags=-O3 -s
#             1
endif

strippy=ostriputil

ifndef ldprefer
	OFLAGSPRE= include_sec 1
endif
ifeq (${nobits_virtual},0)
	OFLAGSPRE+= nobits_virtual 0
endif
ifndef OFLAGS
	OFLAGS= ${OFLAGSPRE}
endif
OFLAGS+= ${OFLAGSEXTRA}

ifndef OCOMP
OCOMP=../src/o
endif

OBJ = ${OB}.o
OBT = ${OB}.txt
FULLOBJ = ./${OB}
FULLOBJS = ${FULLOBJ}.oc
FULLOBJO = ${FULLOBJ}.o
FULLOBJLOG = ${FULLOBJS}.log
OLINK=../ounused/ounused

${OBJ}: ${FULLOBJS}
	${launcher} ${OCOMP} $< ${OFLAGS}

ATCCCOM = $(CC) ${linkerflags} -o
ATLDCOM = $(LD) --dynamic-linker=/lib64/ld-linux-x86-64.so.2 ${linkerflags} ${L} -l:libc.so.6 -entry main -o
#strange that aarch64 cross ld can't -lc but -l:libc.so.6

${OB}: ${OBJ}
	${launcher} ${OLINK} ${FULLOBJLOG}
	if [ -z "${ldprefer}" ]; then \
		${ATCCCOM} ${OB} ${FULLOBJO}; \
	else \
		${ATLDCOM} ${OB} ${FULLOBJO}; \
	fi
	if [ "${nobits_virtual}" != "1" ]; then \
		${FULLOBJ} ${FULLOBJ} ${FULLOBJLOG} ${FULLOBJO}; \
		if [ "$$?" = "0" ]; then \
			${strippy} ${FULLOBJ} ${FULLOBJ}; \
		fi; \
	fi
#	@echo
#without this echo will do a strange cc command
#		if [ "$(shell lsb_release -cs)" = "jammy" ]; then \
#		fi; \
#xenial do wrong access somehow, bionic and focal do extra code at text and need to extra code at realoffset for .text

install:
	$(MAKE) all
	$(MAKE) install-proj
install-proj:
	install -D ${OB} \
		$(DESTDIR)$(prefix)/bin/${OB}

clean-compile:
	-rm -f ${FULLOBJO}
	-rm -f ${FULLOBJLOG}
	-rm -f .data
	-rm -f .text
	-rm -f .rela.dyn
	-rm -f .symtab
	-rm -f .symtab_offset

clean-link:
	-rm -f ${OB}

clean-test:
	-rm -f z

clean: clean-compile clean-link clean-test
distclean: clean

uninstall:
	-rm -f $(DESTDIR)$(prefix)/bin/${OB}

test:
	if [ "${nobits_virtual}" != "1" ]; then \
		if [ -z "${ldprefer}" ]; then \
			${ATCCCOM} z ${FULLOBJO}; \
		else \
			${ATLDCOM} z ${FULLOBJO}; \
		fi; \
		if [ "$$?" = "0" ]; then \
			${FULLOBJ} ./z ${FULLOBJLOG} ${FULLOBJO}; \
			if [ "$$?" = "0" ]; then \
				${strippy} ./z ./z; \
				if [ "$$?" = "0" ]; then \
					diff ./z ${FULLOBJ}; \
				fi; \
			fi; \
		fi; \
	fi

.PHONY: all install install-proj clean clean-compile clean-link clean-test distclean uninstall test
