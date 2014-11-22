# Copyright (C) 2012 Assaf Gordon <gordon@cshl.edu>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

EXTRA_DIST = $(top_srcdir)/.version \
	     bootstrap.sh \
	     gordon_bin_scripts.rb

BUILT_SOURCES = $(top_srcdir)/.version

bin_SCRIPTS = \
	scripts/atexpand \
	scripts/atless \
	scripts/detect_tab_stops \
	scripts/dict \
	scripts/dudirs \
	scripts/easyjoin \
	scripts/filetype_size_breakdown \
	scripts/list_columns \
	scripts/make_balloon \
	scripts/multijoin \
	scripts/nfs_iostat \
	scripts/ppsx \
	scripts/pss \
	scripts/psx \
	scripts/rsx \
	scripts/sort-header \
	scripts/sum_file_sizes \
	scripts/sumcol \
	scripts/tawk \
	scripts/tardir \
	scripts/tuniq \
	scripts/xtime \
	scripts/xxcat

$(top_srcdir)/.version:
	            echo $(VERSION) > $@-t && mv $@-t $@

dist-hook:
	            echo $(VERSION) > $(distdir)/.tarball-version
