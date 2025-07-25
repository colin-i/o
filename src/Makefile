
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
#there is not supposed to be a /usr/etc, /usr is read-only
#move back is not working on fedora if sbin/o and on suse interactive bash(in scripts is ok) o is another alias and ocompiler is with move back
ifeq ($(prefix),/usr)
	PREFFILEFULL=$(DESTDIR)/etc/${PREFFILE}
	##also move back the usr folder: usr/bin/o
	##$((3+1+3+1+${#projname}))
	#etchelper=9
	#etc_helper=usr/bin/o
	etc_helper=/etc/${PREFFILE}
else
	PREFFILEFULL=$(DESTDIR)$(prefix)/etc/${PREFFILE}
	##move back only exec name and bin folder: /usr/local/etc is ok. bin/o
	##$((3+1+${#projname}))
	#etchelper=5
	#etc_helper=bin/o
	etc_helper=$(prefix)/etc/${PREFFILE}
endif
etcinclude=etcinclude.oc
#debian/ocompiler.install is forcing to usr/ / etc/

#OFLAGS=

ver=version.oh
vers=../${ver}
${vers}:
	cd .. && $(MAKE) -f ./Makefile ${ver}

#       this is in case .oc file is modified
${OBJ}: ${FULLOBJS} ${etcinclude} ${vers}
	if [ -s ${OBT} ];then \
		echo text; \
		base64 -d ${OBT} > $@; \
		${_ATLDCOM} o $@ ${AFTERLDCOM}; \
		${launcher} ./o ${FULLOBJS} ${OFLAGS}; \
	else \
		${OCOMP} $< ${OFLAGS}; \
	fi; \
	mv ${FULLOBJO} . \

#suse will not work if -l is not at end
AFTERLDCOM = ${L} -l:libc.so.6
_ATLDCOM = $(LD) ${linkerflags} -melf_i386 --dynamic-linker=${linker} --build-id -entry main -o
ATLDCOM = ${_ATLDCOM} $@
ATLDCOM_T_O = $(LD) -melf_i386 --dynamic-linker=${linker} -entry main -o z ${FULLOBJO} ${AFTERLDCOM}
#--build-id for rpm

${etcinclude}:
	echo ss etc_helper=\"${etc_helper}\" > ${etcinclude}
#sd etchelper=${etchelper}\;

${projname}: ${OBJ}
	${ATLDCOM} $^ ${AFTERLDCOM}
#$^ is all objects here, $< is first object

install:
	$(MAKE) all
	$(MAKE) install-proj
install-proj:
	install -D o $(DESTDIR)$(prefix)/bin/o
	if [ -e ../ocompiler_is_o ]; then\
		ln -s o $(DESTDIR)$(prefix)/bin/ocompiler;\
	fi
	install -D ../${PREFFILE} ${PREFFILEFULL}
	if [ -e ../include_dev ]; then \
		install -D files/headers/logs.oh $(DESTDIR)$(prefix)/include/ocompiler/logs.oh && \
		install -D files/headers/log.oh $(DESTDIR)$(prefix)/include/ocompiler/log.oh && \
		install -D files/headers/xfilecore.oh $(DESTDIR)$(prefix)/include/ocompiler/xfilecore.oh && \
		install -D files/headers/xfile.oh $(DESTDIR)$(prefix)/include/ocompiler/xfile.oh; \
	fi
#at suse, at use interactive bash (not inside scripts) o is another alias
#not install because is not installing a link
#ln -s o %{_buildrootdir}/BUILDROOT%{_bindir}/ocompiler || ln -s o %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}%{_bindir}/ocompiler #this because at use interactive bash (not inside scripts) o is another alias
#ln here because since debian .install file, will go through that
#		ln -s o ocompiler;\

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
	if [ -e ../ocompiler_is_o ]; then\
		-rm -f $(DESTDIR)$(prefix)/bin/ocompiler;\
	fi
	-rm -f ${PREFFILEFULL}
	-if [ -e ../include_dev ]; then\
		rm -f $(DESTDIR)$(prefix)/include/ocompiler/logs.oh;\
		rm -f $(DESTDIR)$(prefix)/include/ocompiler/log.oh;\
		rm -f $(DESTDIR)$(prefix)/include/ocompiler/xfilecore.oh;\
		rm -f $(DESTDIR)$(prefix)/include/ocompiler/xfile.oh;\
	fi
#		-rm -f ocompiler;\

test-obj:
	${launcher} ./o linux/obj.oc function_name 1 nul_res_pref 1
	${ATLDCOM_T_O}
	${launcher} ./z linux/obj.oc function_name 1 nul_res_pref 1
	mv z zz
	${ATLDCOM_T_O}
	diff z zz
test: test-obj
	cd linux; ${launcher} ../o o.oc nul_res_pref 1; mv o z; \
	if [ -z "${testlinker}" ]; then \
		RUN__SHELL=$(SHELL) . ../../shl && cd ../../ && $${RUN__SHELL} ./test32; \
	else \
		LD_LIBRARY_PATH=${testlinker} ${launcher2} ${testlinker}/ld-linux.so.2 ./z o.oc nul_res_pref 1; \
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
