
OB = ounused

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
ifndef prefix
prefix=/usr
endif

ver=version.oh
vers=../${ver}

OFLAGS=
#export OFLAGS inside will not be enough
ifneq (${platform},win)

OFLAGS=exit_end 1 underscore_pref 1
all: ${OB}
${OB}: ${OBJ}
	$(LD) ${linkerflags} -melf_i386 --dynamic-linker=/lib/ld-linux.so.2 --build-id -o $@ ${L} -l:libc.so.6 -entry main ${FULLOBJO}
	${launcher} ./${OB} ${FULLOBJLOG}

else

OFLAGS=inplace_reloc 0 include_sec 1
all: ${OB}.exe
${OB}.exe: ${OBJ}
	i686-w64-mingw32-gcc ${linkerflags} ${FULLOBJO} -o $@

endif

${vers}:
	cd .. && $(MAKE) -f ./Makefile ${ver}

${FULLOBJO}: ${FULLOBJS} ${vers}
	${launcher} ${OCOMP} $< ${OFLAGS} ${OFLAGSEXTRA}

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
