
projname=o

all: ${projname}

OB = obj
OBJ = ${OB}.o
FULLOBJ = ./linux/${OB}
FULLOBJS = ${FULLOBJ}.oc
FULLOBJO = ${FULLOBJ}.o
OBT = ${OB}.txt

ifndef OCOMP
OCOMP=o
endif

ifndef linkerflags
linkerflags=-O3 -s
#             1
endif

linker=/lib/ld-linux.so.2

ifndef prefix
prefix=/usr
endif

#set preffile data
PREFFILE=ocompiler.conf
#there is not suposed to be a /usr/etc, /usr is read-only
ifeq ($(prefix),/usr)
	PREFFILEFULL=$(DESTDIR)/etc/${PREFFILE}
	#also move back the usr folder: usr/bin/o
	#$((3+1+3+1+${#projname}))
	etchelper=9
	etc_helper=usr/bin/o
else
	PREFFILEFULL=$(DESTDIR)$(prefix)/etc/${PREFFILE}
	#move back only exec name and bin folder: /usr/local/etc is ok. bin/o
	#$((3+1+${#projname}))
	etchelper=5
	etc_helper=bin/o
endif
etcinclude=etcinclude.oc
#debian/ocompiler.install is forcing to usr/ / etc/

#OFLAGS=

ver=version.h
vers=../${ver}
${vers}:
	cd .. && $(MAKE) -f ./Makefile ${ver}

#       this is in case .oc file is modified
${OBJ}: ${FULLOBJS} ${etcinclude} ${vers}
	if [ -s ${OBT} ];then \
		echo text; \
		base64 -d ${OBT} > $@; \
		${_ATLDCOM} o $@; \
		${launcher} ./o ${FULLOBJS} ${OFLAGS}; \
	else \
		${OCOMP} $< ${OFLAGS}; \
	fi; \
	mv ${FULLOBJO} . \

_ATLDCOM = $(LD) ${linkerflags} -melf_i386 --dynamic-linker=${linker} ${L} -lc -entry main -o
ATLDCOM = ${_ATLDCOM} $@
ATLDCOM_T_O = $(LD) -melf_i386 --dynamic-linker=${linker} ${L} -lc -entry main -o z ${FULLOBJO}

${etcinclude}:
	echo sd etchelper=${etchelper}\;ss etc_helper=\"${etc_helper}\" > ${etcinclude}

${projname}: ${OBJ}
	${ATLDCOM} $^
#$^ is all objects here, $< is first object

install:
	$(MAKE) all
	$(MAKE) install-proj
install-proj:
	install -D o \
		$(DESTDIR)$(prefix)/bin/o
	install -D ../${PREFFILE} ${PREFFILEFULL}

clean-compile:
	-rm -f ${OBJ}
	-rm -f ${FULLOBJS}.log
	-rm -f ${etcinclude}
	-rm -f ${vers}
clean-link:
	-rm -f o
clean-test:
	-rm -f ./linux/o
	-rm -f ./linux/o.oc.log
	-rm -f ./linux/z
clean-test-obj:
	-rm -f ${FULLOBJO}
	-rm -f z
	-rm -f zz

clean: clean-compile clean-link clean-test clean-test-obj
distclean: clean

uninstall:
	-rm -f $(DESTDIR)$(prefix)/bin/o
	-rm -f ${PREFFILEFULL}

test-obj:
	./o linux/obj.oc function_name 1 nul_res_pref 1
	${ATLDCOM_T_O}
	./z linux/obj.oc function_name 1 nul_res_pref 1
	mv z zz
	${ATLDCOM_T_O}
	diff z zz
test: test-obj
	cd linux; ../o o.oc nul_res_pref 1; mv o z; \
	if [ -z "${testlinker}" ]; then \
		RUN__SHELL=$(SHELL) . ../../shl && cd ../../ && $${RUN__SHELL} ./test32; \
	else \
		LD_LIBRARY_PATH=${testlinker} ${testlinker}/ld-linux.so.2 ./z o.oc nul_res_pref 1; \
		diff o z; \
	fi
#cannot extern LD_LIBRARY_PATH, will wrong between them
#use ./test32
#there is a backport in ppa-stagging for jammy
#still at xenial/bionic but launchpad stop working for ./z . solution? local test

${OBT}: ${FULLOBJS} ${etcinclude} ${vers}
	${OCOMP} ${FULLOBJS} ${OFLAGS}
	base64 ${FULLOBJO} > $@
	$(MAKE) ${OBJ}
	base64 ${OBJ} > $@2
	diff $@ $@2
	rm $@2
	mv $@ ..
	echo ok

.PHONY: all install install-proj clean clean-compile clean-link clean-test clean-test-obj distclean uninstall test test-obj
