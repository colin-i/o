
all: o

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

#OFLAGS=

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

o: ${OBJ}
	${ATLDCOM} $^

install: all
	install -D o \
		$(DESTDIR)$(prefix)/bin/o

clean-compile:
	-rm -f ${OBJ}
	-rm -f ${FULLOBJS}.log

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

test:
	echo "test"
	cd linux; ../o o.s nul_res_pref 1; mv o z; ${linker} ./z o.s nul_res_pref 1; diff o z
#/home/bc/Desktop/out/libc6-i386.AppImage /home/bc/o/ocompiler-1/src/linux/z /home/bc/o/ocompiler-1/src/linux/o.s nul_res_pref 1
#2.36-0ubuntu4 (jammy) was ok, backportpackage is working for esm packages (tested)

.PHONY: all install clean distclean uninstall test
