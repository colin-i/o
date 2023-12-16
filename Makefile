TOPTARGETS := all install clean distclean uninstall test

ifeq ($(shell dpkg-architecture -qDEB_HOST_ARCH), amd64)
SUBDIRS := src ounused otoc ostrip
conv_64=0
else
SUBDIRS := src ounused
conv_64=1
endif

$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	conv_64=${conv_64} $(MAKE) -C $@ $(MAKECMDGOALS)
.PHONY: $(TOPTARGETS) $(SUBDIRS)


all:
	#if ! [ -s ./src/obj.txt ];then
	cd ./src; ../ounused/ounused ./linux/obj.s.log
	#; fi
	@echo

.NOTPARALLEL:
