
TOPTARGETS := install-proj clean distclean uninstall test

#NOOCONV ? is at debian/ocompiler.install , will install here but not in the final deb

#                                                             || arch/fedora/suse
ARCH := $(shell dpkg-architecture -qDEB_HOST_ARCH 2>/dev/null || uname -m)
ARCH := $(patsubst i686,i386,$(ARCH))

ifeq ($(ARCH),i386)
	conv_64=1
else
	ifndef conv_64
		conv_64=0
	endif
endif

ifeq ($(conv_64),1)
SUBDIRS := src ounused otoc
else
SUBDIRS := src ounused ostrip otoc
endif

#all must be first rule (rule: ...) to be executed in case of make with no args
all: $(SUBDIRS)
	$(MAKE) verify_comp_with_link

$(TOPTARGETS): $(SUBDIRS)

install:
	$(MAKE) all
	$(MAKE) install-proj
$(SUBDIRS):
	conv_64=${conv_64} $(MAKE) -C $@ $(MAKECMDGOALS)

verify_comp_with_link:
	cd ./src; ${launcher} ../ounused/ounused ./linux/obj.oc.log
version.oh:
	RUN__SHELL=$(SHELL) . ./shl && $${RUN__SHELL} ./versionscript
#s=`pwd`; cd ${s} is working here, is not working on launchpad

test:
	RUN__SHELL=$(SHELL) . ./shl && cd tests && RUN__SHELL="$${RUN__SHELL}" $${RUN__SHELL} ./tests

clean:
	-rm -f version.oh
	RUN__SHELL=$(SHELL) . ./shl && cd tests && $${RUN__SHELL} ./c

#phony only in this file not in subdirs, then can write extra for a PHONYTOPTARGETS
.PHONY: all install $(TOPTARGETS) $(SUBDIRS) verify_comp_with_link
.NOTPARALLEL:
