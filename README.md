Collection of useful scripts
============================

Copyright (C) 2010-2016 A. Gordon (assafgordon@gmail.com)

Available scripts
-----------------

* atexpand - like 'expand', but with auto-tab width detection.
* atless - like 'less', but with auto-tab width detection.
* auto-build-install - downloads,builds,install a tarball from http/ftp/s3/git
* create-ssha-passwd - creates SSHA-encoded password lines (e.g. for NGINX)
* detect_tab_stops - help script to detect proper tab width.
* dict - like 'dict', but pipes to 'less'.
* dudirs - friendlier output of 'du'.
* easyjoin - combines 'sort' + 'join' into one quick script.
* filetype_size_breakdown - summarize file usage by file type.
* list_columns - shows names and number of columns in a tabular file.
* make_balloon - easily create big empty files.
* multijoin - combine multiple files using shared key.
* nfs_iostat - wrapper for NFS statistics of iostat.
* pss - 'ps' with nicer output and easy filtering.
* ppsx - copy user+hostname+fullpath of file/dir to clipboard.
* psx - copy fullpath of file/dir to clipboard.
* rsx - copy rsync-compatible URL of file/dir to clipboard.
* run-with-log - run a program, log stdout/err to file, email log on errors.
* sort-header - wrapper for GNU sort, with header line support.
* sum_file_sizes - sum the size of files.
* sumcol - sum the values in a column of input file.
* tawk - AWK wrapper, with input/output field separators set to TAB.
* tardir - packs current directory into a time-stamped tarball.
* tuniq - UNIQ wrapper, with TAB output.
* xtime - xtime wrapper, with friendlier output.
* xxcat - 'cat' wrapper, with auto de-compression of gzip/bzip2/xz files.


INSTALLATION
------------

When using the released tarball version ( https://github.com/agordon/bin_scripts/releases ):

    tar -xzvf gordon-bin-scripts-X.Y.Z.tar.gz
    cd gordon-bin-scripts-X.Y.Z
    ./configure
    make
    sudo make install

When using the GIT repository:

    git clone git://github.com/agordon/bin_scripts.git
    cd bin_scripts
    ./bootstrap
    ./configure
    make
    sudo make install

When using HomeBrew/LinuxBrew:

    brew install --HEAD https://raw.github.com/agordon/bin_scripts/master/gordon_bin_scripts.rb

SOURCE
------
See here: https://github.com/agordon/bin_scripts

LICENSE
-------
GPLv3+
