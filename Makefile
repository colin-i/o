TOPTARGETS := all install clean distclean uninstall test

ifeq ($(shell dpkg-architecture -qDEB_HOST_ARCH), amd64)
SUBDIRS := src ounused ostrip otoc
conv_64=0
else
SUBDIRS := src ounused otoc
conv_64=1
endif

$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	conv_64=${conv_64} $(MAKE) -C $@ $(MAKECMDGOALS)
.PHONY: $(TOPTARGETS) $(SUBDIRS)

ver=version.h

${ver}:
	/bin/bash ./versionscript

all: ${ver}
	#if ! [ -s ./src/obj.txt ];then
	cd ./src; ${launcher} ../ounused/ounused ./linux/obj.oc.log
	#; fi
	@echo

test:
	cd tests; /bin/bash ./tests

clean:
	-rm -f ${ver}

.NOTPARALLEL:
