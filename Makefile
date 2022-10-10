TOPTARGETS := all install clean distclean uninstall test

SUBDIRS := src ounused

$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)
.PHONY: $(TOPTARGETS) $(SUBDIRS)


all:
	cd ./ounused; ./ounused ./ounused.s.log
	@echo
	if ! [ -f ./src/obj.o ];then cd ./src; ../ounused/ounused ./linux/obj.s.log; fi
	@echo

.NOTPARALLEL:
