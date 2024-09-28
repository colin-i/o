TOPTARGETS := all install clean distclean uninstall test

#NOOCONV ? is at debian/ocompiler.install , will install here but not in the final deb

ifeq ($(shell dpkg-architecture -qDEB_HOST_ARCH), amd64)
SUBDIRS := src ounused ostrip otoc
conv_64=0
else
SUBDIRS := src ounused otoc
conv_64=1
endif

version.h:
	s=`pwd`; cd ..; /bin/bash ./versionscript; cd ${s}

#if ! [ -s ./src/obj.txt ];then
verify_comp_with_link:
	cd ./src; ${launcher} ../ounused/ounused ./linux/obj.oc.log

$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	conv_64=${conv_64} $(MAKE) -C $@ $(MAKECMDGOALS)
#if only after ':' is after; if after ':' and below, one is at start the other one at end
all install:
	$(MAKE) verify_comp_with_link

test:
	cd tests; /bin/bash ./tests

clean:
	-rm -f ${ver}
	cd tests; /bin/bash ./c

#phony only in this file not in subdirs, then can write extra for a PHONYTOPTARGETS
.PHONY: $(TOPTARGETS) $(SUBDIRS) verify_comp_with_link
.NOTPARALLEL:
