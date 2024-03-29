# Process this file with autoconf to produce a configure script.
AC_PREREQ([2.69])
AC_INIT([xllmnrd], [3.0],
[https://bitbucket.org/kazssym/xllmnrd/issues/new],,
[http://xllmnrd.vx68k.org/])
AC_CONFIG_SRCDIR([src/responder.c])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_HEADERS([config.h])
AM_INIT_AUTOMAKE([no-define])

# Define the unique package revision if 'config.revision' exists.
if test -f $srcdir/config.revision; then
  PACKAGE_REVISION=
  . $srcdir/config.revision
  AC_DEFINE_UNQUOTED([PACKAGE_REVISION], ["$PACKAGE_REVISION"],
  [Define to the unique revision of this package.])dnl
fi

# Checks for programs.
AC_PROG_CC
AC_PROG_CC_STDC
gl_EARLY
AC_PROG_CXX
AC_PROG_RANLIB
XX_PROG_CXX_STD11

# Checks for libraries.
AC_SEARCH_LIBS([pthread_create], [pthread])

# Checks for header files.
AC_DEFINE([_POSIX_C_SOURCE], [200809L],
[Define to 200809L to make the symbols required by IEEE Std 1003.1-2008 \
visible if available.])dnl
AC_HEADER_STDBOOL
AC_CHECK_HEADERS([arpa/inet.h libgen.h linux/rtnetlink.h netinet/in.h \
net/if.h syslog.h sys/socket.h])
AM_GNU_GETTEXT([external])
AM_GNU_GETTEXT_VERSION([0.19.3])
gl_INIT

# Checks for typedefs, structures, and compiler characteristics.
dnl 'AC_C_INLINE' was omitted as 'inline' is now standard in C99 and C++.
dnl Note: on the other hand, 'restrict' is not standard in C++ yet.
AC_C_RESTRICT
AC_TYPE_SSIZE_T
AC_TYPE_UINT8_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T

# Checks for library functions.
dnl 'AC_FUNC_MALLOC' and 'AC_FUNC_REALLOC' were omitted as only the standard
dnl behavior is used.
AC_CHECK_FUNCS([basename daemon gethostname socket])

AM_PATH_CPPUNIT([1.12.1])
AC_CONFIG_FILES([Makefile libgnu/Makefile src/Makefile lsb/Makefile \
po/Makefile.in])
AC_OUTPUT
