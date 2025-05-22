
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
ifndef exelauncher
exelauncher=${launcher}
endif

ver=version.oh
vers=../${ver}

OFLAGS=
#export OFLAGS inside will not be enough
platform_ob=
ifneq (${platform},win)

OFLAGS=exit_end 1 underscore_pref 1
platform_ob=${OB}
all: ${platform_ob} link
${platform_ob}: ${OBJ}
	$(LD) ${linkerflags} -melf_i386 --dynamic-linker=/lib/ld-linux.so.2 --build-id -o $@ ${L} -l:libc.so.6 -entry main ${FULLOBJO}

else

OFLAGS=inplace_reloc 0 include_sec 1
platform_ob=${OB}.exe
all: ${platform_ob} link
${platform_ob}: ${OBJ}
	i686-w64-mingw32-gcc ${linkerflags} ${FULLOBJO} -o $@

endif

link:
	${exelauncher} ./${platform_ob} ${FULLOBJLOG}

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
	-rm -f ${platform_ob}

clean: clean-compile clean-link
distclean: clean

uninstall:
	-rm -f $(DESTDIR)$(prefix)/bin/${OB}

test:
	echo "Nothing"

.PHONY: all install install-proj clean clean-compile clean-link distclean uninstall test link
