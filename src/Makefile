
projname=o

../version.h:
	$(MAKE) -f ../Makefile version.h
all: ../version.h ${projname}

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

#       this is in case .oc file is modified
${OBJ}: ${FULLOBJS} ${etcinclude}
	if [ -s ${OBT} ];then \
		echo text; \
		base64 -d ${OBT} > $@; \
		${_ATLDCOM} o $@; \
		./o ${FULLOBJS}; \
	else \
		${OCOMP} $< ${OFLAGS}; \
	fi; \
	mv ${FULLOBJO} . \

_ATLDCOM = $(LD) ${linkerflags} -melf_i386 --dynamic-linker=${linker} -lc -entry main -o
ATLDCOM = ${_ATLDCOM} $@

${etcinclude}:
	echo sd etchelper=${etchelper}\;ss etc_helper=\"${etc_helper}\" > ${etcinclude}

${projname}: ${OBJ}
	${ATLDCOM} $^
#$^ is all objects here, $< is first object

install: all
	install -D o \
		$(DESTDIR)$(prefix)/bin/o
	install -D ../${PREFFILE} ${PREFFILEFULL}

clean-compile:
	-rm -f ${OBJ}
	-rm -f ${FULLOBJS}.log
	-rm -f ${etcinclude}

clean-link:
	-rm -f o

clean-test:
	-rm -f ./linux/o
	-rm -f ./linux/o.oc.log
	-rm -f ./linux/z

clean: clean-compile clean-link clean-test
distclean: clean

uninstall:
	-rm -f $(DESTDIR)$(prefix)/bin/o
	-rm -f ${PREFFILEFULL}

test:
	echo "test"
	cd linux; ../o o.oc nul_res_pref 1; mv o z; \
	if [ -z "${testlinker}" ]; then \
		./z o.oc nul_res_pref 1; \
	else \
		LD_LIBRARY_PATH=${testlinker} ${testlinker}/ld-linux.so.2 ./z o.oc nul_res_pref 1; \
	fi; \
	diff o z
#cannot extern LD_LIBRARY_PATH, will wrong between them
#use ./test32
#there is a backport in ppa-stagging for jammy

.PHONY: all install clean distclean uninstall test
#for ../version.h first
.NOTPARALLEL:
