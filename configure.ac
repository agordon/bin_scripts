dnl   Copyright (C) 2012 Assaf Gordon <gordon@cshl.edu>
dnl
dnl   This file is free software; as a special exception the author gives
dnl   unlimited permission to copy and/or distribute it, with or without
dnl   modifications, as long as this notice is preserved.
dnl
dnl   This program is distributed in the hope that it will be useful, but
dnl   WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
dnl   implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

AC_INIT([gordon_bin_scripts],
        m4_esyscmd([config/git-version-gen .tarball-version]),
	[gordon@cshl.edu])

AC_CONFIG_AUX_DIR(config)
AM_INIT_AUTOMAKE([])
AC_CONFIG_MACRO_DIR([m4])

AC_PROG_LN_S

AC_SUBST(LICENSE,[AGPLv3-or-later])

AC_SUBST(VERSION)

AC_CONFIG_FILES( [
		  Makefile
		  scripts/atexpand
		  scripts/atless
		  scripts/detect_tab_stops
		  scripts/dict
		  scripts/dudirs
		  scripts/easyjoin
		  scripts/filetype_size_breakdown
		  scripts/list_columns
		  scripts/make_balloon
		  scripts/multijoin
		  scripts/nfs_iostat
		  scripts/ppsx
		  scripts/pss
		  scripts/sort-header
		  scripts/sum_file_sizes
		  scripts/sumcol
		  scripts/tawk
		  scripts/tardir
		  scripts/tuniq
		  scripts/xtime
		  scripts/xxcat
		  ] )

AC_OUTPUT()
