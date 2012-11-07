
AC_INIT([gordon_bin_scripts],
        m4_esyscmd([config/git-version-gen .tarball-version]),
	[gordon@cshl.edu])

AC_CONFIG_AUX_DIR(config)
AM_INIT_AUTOMAKE([])
AC_CONFIG_MACRO_DIR([m4])

AC_SUBST(VERSION)

AC_CONFIG_FILES( [
		  Makefile
		  scripts/Makefile
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
		  scripts/psx
		  scripts/rsx
		  scripts/sort-header
		  scripts/sum_file_sizes
		  scripts/sumcol
		  scripts/tawk
		  scripts/tuniq
		  scripts/xtime
		  scripts/xxcat
		  ] )

dnl AC_CONFIG_FILES([foo], [chmod +x foo])

AC_OUTPUT()
