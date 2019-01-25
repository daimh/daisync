#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([daisync], [20190124], [daimh@umich.edu])
AM_INIT_AUTOMAKE()
AC_OUTPUT(Makefile man/Makefile scripts/Makefile)
# Checks for programs.
AC_CHECK_PROG(CHECK_bc,bc,yes)
if test x"$CHECK_bc" != x"yes"; then
	AC_MSG_ERROR([Please install bc])
fi
AC_CHECK_PROG(CHECK_df,df,yes)
if test x"$CHECK_df" != x"yes"; then
	AC_MSG_ERROR([Please install df])
fi
AC_CHECK_PROG(CHECK_flock,flock,yes)
if test x"$CHECK_flock" != x"yes"; then
	AC_MSG_ERROR([Please install flock])
fi
AC_CHECK_PROG(CHECK_fuser,fuser,yes)
if test x"$CHECK_fuser" != x"yes"; then
	AC_MSG_ERROR([Please install fuser])
fi
AC_CHECK_PROG(CHECK_locate,locate,yes)
if test x"$CHECK_locate" != x"yes"; then
	AC_MSG_ERROR([Please install locate])
fi
AC_CHECK_PROG(CHECK_md5sum,md5sum,yes)
if test x"$CHECK_md5sum" != x"yes"; then
	AC_MSG_ERROR([Please install md5sum])
fi
AC_CHECK_PROG(CHECK_rsync,rsync,yes)
if test x"$CHECK_rsync" != x"yes"; then
	AC_MSG_ERROR([Please install rsync])
fi
AC_CHECK_PROG(CHECK_shuf,shuf,yes)
if test x"$CHECK_shuf" != x"yes"; then
	AC_MSG_ERROR([Please install shuf])
fi
AC_CHECK_PROG(CHECK_updatedb,updatedb,yes)
if test x"$CHECK_updatedb" != x"yes"; then
	AC_MSG_ERROR([Please install updatedb])
fi
# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_OUTPUT
