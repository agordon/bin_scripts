SUBDIRS = scripts

EXTRA_DIST = $(top_srcdir)/.version \
	     bootstrap.sh

BUILT_SOURCES = $(top_srcdir)/.version

$(top_srcdir)/.version:
	            echo $(VERSION) > $@-t && mv $@-t $@

dist-hook:
	            echo $(VERSION) > $(distdir)/.tarball-version
