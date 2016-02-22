# Copyright (C) 2012-2014 Assaf Gordon <assafgordon@gmail.com>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

EXTRA_DIST = $(top_srcdir)/.version \
	     bootstrap \
	     gordon_bin_scripts.rb

BUILT_SOURCES = $(top_srcdir)/.version

bin_SCRIPTS = \
	scripts/auto-build-install \
	scripts/atexpand \
	scripts/atless \
	scripts/create-ssha-passwd \
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
	scripts/sort-header \
	scripts/sum_file_sizes \
	scripts/sumcol \
	scripts/tawk \
	scripts/tardir \
	scripts/tuniq \
	scripts/xtime \
	scripts/xxcat

## During installation, create symlinks
## from 'ppsx' to 'psx' and 'rsx'.
install-exec-hook:
	cd $(DESTDIR)$(bindir) && \
	  $(LN_S) -f ppsx psx && \
	  $(LN_S) -f ppsx rsx

$(top_srcdir)/.version:
	            echo $(VERSION) > $@-t && mv $@-t $@

dist-hook:
	            echo $(VERSION) > $(distdir)/.tarball-version
