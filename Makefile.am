## Process this file with automake to produce a Makefile.in.

ACLOCAL_AMFLAGS = -Ilibgnu/m4 -Im4

SUBDIRS = libgnu src lsb po

dist-hook:
	revision=`cd $(srcdir) && hg identify -i 2> /dev/null`; \
	if test -n "$$revision"; then \
	  echo "PACKAGE_REVISION='$$revision'" > $(distdir)/config.revision; \
	fi
	@rm -f SHASUM-dist
	(cd $(distdir) && find . -type f -print | sort | xargs shasum) \
	  > SHASUM-dist
	mv -f SHASUM-dist $(distdir)/SHASUM
	@if test -x pgpsign; then \
	  ./pgpsign $(distdir)/SHASUM; \
	fi
