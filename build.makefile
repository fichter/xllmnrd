# -*-Makefile-*- for maintenance jobs
# Copyright (C) 2013  Kaz Nishimura

# Copying and distribution of this file, with or without modification, are
# permitted in any medium without royalty provided the copyright notice and
# this notice are preserved.  This file is offered as-is, without any
# warranty.

# This file SHOULD NOT be contained in the source package.

topdir := $(if $(WORKSPACE),$(WORKSPACE),$(shell pwd))
srcdir = $(topdir)
builddir = $(topdir)/_build
prefix = $(topdir)/_usr

AUTORECONF = autoreconf
TAR = tar

CFLAGS = -g -O2 -Wall -Wextra

build: clean install dist
	hg status || true

all check uninstall clean distclean: $(builddir)/Makefile
	cd $(builddir) && $(MAKE) CFLAGS='$(CFLAGS)' $@

install: $(builddir)/Makefile
	rm -fr $(prefix)
	cd $(builddir) && $(MAKE) CFLAGS='$(CFLAGS)' $@

dist distcheck: $(builddir)/Makefile update-ChangeLog
	rm -f $(builddir)/xllmnrd-*.*
	cd $(builddir) && $(MAKE) CFLAGS='$(CFLAGS)' $@

$(builddir)/Makefile: stamp-configure build.makefile
	mkdir -p $(builddir)
	cd $(builddir) && $(srcdir)/configure --prefix=$(prefix)

configure: stamp-configure
stamp-configure: configure.ac
	@rm -f $@
	$(AUTORECONF) --install
	touch $@

update-ChangeLog:
	@rm -f ChangeLog-t
	hg log -C --style=changelog -X .hg\* -X README.md -X build.makefile \
	  -r "sort(::. and not merge(), -date)" | \
	sed -e 's/`\([^`]*\)`/'\''\1'\''/g' -e 's/NLS-support/NLS/g' > ChangeLog-t
	if test -s ChangeLog-t && ! cmp -s ChangeLog-t ChangeLog; then \
	  mv -f ChangeLog-t ChangeLog; \
	else \
	  rm -f ChangeLog-t; \
	fi

.PHONY: build all check install uninstall dist distcheck clean distclean \
update-ChangeLog
