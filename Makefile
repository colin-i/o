TOPTARGETS := all install clean distclean uninstall test

SUBDIRS := src srcres

$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)
.PHONY: $(TOPTARGETS) $(SUBDIRS)
