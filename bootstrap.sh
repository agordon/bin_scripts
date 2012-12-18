# Copyright (C) 2008 Assaf Gordon <gordon@cshl.edu>
#  
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without 
# modifications, as long as this notice is preserved.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#!/bin/sh
rm -rf config.cache autom4te.cache aclocal.m4 .version .tarball_version

mkdir -p config
echo "- aclocal."
mkdir -p m4
aclocal -I m4
echo "- autoconf."
autoconf
echo "- automake."
automake -a --foreign

