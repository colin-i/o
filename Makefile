TOPTARGETS := all install clean distclean uninstall test

ifeq ($(shell dpkg-architecture -qDEB_HOST_ARCH), amd64)
SUBDIRS := src ounused ostrip
conv_64=0
else
SUBDIRS := src ounused
conv_64=1
endif

$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	conv_64=${conv_64} $(MAKE) -C $@ $(MAKECMDGOALS)
.PHONY: $(TOPTARGETS) $(SUBDIRS)

ver=version.h

${ver}:
	./versionscript

all: ${ver}
	#if ! [ -s ./src/obj.txt ];then
	cd ./src; ../ounused/ounused ./linux/obj.oc.log
	#; fi
	@echo

test:
	cd tests; /bin/bash ./tests

clean:
	-rm -f ${ver}

.NOTPARALLEL:
