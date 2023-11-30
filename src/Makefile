
projname=o

all: ${projname}

OB = obj
OBJ = ${OB}.o
FULLOBJ = ./linux/${OB}
FULLOBJS = ${FULLOBJ}.s
FULLOBJO = ${FULLOBJ}.o
OBT = ${OB}.txt

ifndef OCOMP
OCOMP=o
endif

ifndef linkerflags
linkerflags=-O1 -s
endif

ifndef linker
linker=/lib/ld-linux.so.2
endif

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
etcinclude=etcinclude.s
#debian/ocompiler.install is forcing to usr/ / etc/

#OFLAGS=

${FULLOBJS}: ${etcinclude}

%.o: ${FULLOBJS}
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
	-rm -f ./linux/o.s.log
	-rm -f ./linux/z

clean: clean-compile clean-link clean-test
distclean: clean

uninstall:
	-rm -f $(DESTDIR)$(prefix)/bin/o
	-rm -f ${PREFFILEFULL}

test:
	echo "test"
	cd linux; ../o o.s nul_res_pref 1; mv o z; ${linker} ./z o.s nul_res_pref 1; diff o z
#/home/bc/Desktop/out/libc6/lib32/ld-linux.so.2 /home/bc/o/ocompiler-1/src/linux/z /home/bc/o/ocompiler-1/src/linux/o.s nul_res_pref 1
#/home/bc/Desktop/out/libc6-i386.AppImage
#2.36-0ubuntu4 (jammy) was ok, backportpackage is working for esm packages (tested)
#DEB_BUILD_OPTIONS=nocheck debuild -us -uc

.PHONY: all install clean distclean uninstall test
