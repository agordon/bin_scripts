# Copyright (C) 2012 Assaf Gordon <gordon@cshl.edu>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

SUBDIRS = scripts

EXTRA_DIST = $(top_srcdir)/.version \
	     bootstrap.sh

BUILT_SOURCES = $(top_srcdir)/.version

$(top_srcdir)/.version:
	            echo $(VERSION) > $@-t && mv $@-t $@

dist-hook:
	            echo $(VERSION) > $(distdir)/.tarball-version
