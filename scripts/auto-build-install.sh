#!/bin/sh

# @autogenerated_warning@
# @autogenerated_timestamp@
# @PACKAGE@ @VERSION@
# @PACKAGE_URL@

COPYRIGHT="
Copyright (C) 2014-2016  A. Gordon (assafgordon@gmail.com)
License: GPLv3+
"

## Copyright (C) 2015 Assaf Gordon <assafgordon@gmail.com>
## Download, Build, Install a given package (based on autotools).
##
## Based on 'pretest-auto-build-check' from PreTest (http://pretest.nongnu.org)
##  Copyright (C) 2014 Assaf Gordon <assafgordon@gmail.com>
##  License: GPLv3-or-later

# Terrible hack for OpenSolaris:
# The default grep,tail are not posix complient (doesn't support -E/-n)
# And find doesn't support '-maxdepth'
if test SunOS = "$(uname -s)" ; then
    PATH=/usr/gnu/bin:/usr/xpg6/bin:/usr/xpg4/bin/:/opt/csw/bin:usr/sfw/bin:$PATH
    export PATH
fi

die()
{
    BASE=$(basename "$0")
    echo "$BASE: error: $@" >&2
    exit 1
}

validate_simple_name()
{
    # ensure the name contains only 'simple' characters
    ___tmp1=$(echo "$1" | tr -d -c 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789._%^~-')
    test "x$1" = "x${___tmp1}" \
    || die "name '$1' contains non-regular characters; " \
           "Aborting to avoid potential troubles. " \
           "Please use only 'A-Za-z0-9.~_%^.-' ."
}


show_help_and_exit()
{
    BASE=$(basename "$0")
    echo "
$BASE - download, build & install a tarball (or git repo) based on autotools.
$COPYRIGHT
Version: @VERSION@
See: @PACKAGE_URL@

Usage:  $BASE [OPTIONS] SOURCE

SOURCE - A source for the package, either:
  1. a local tarball filename
  2. a remote tarball filename (http/ftp)
  3. a remote git repository
  4. a remote file on AWS S3 (requires 'aws' program)

OPTIONS:
   -h          - This help screen.
   -b BRANCH   - If SOURCE is GIT, check-out BRANCH
                 (instead of the default 'master' branch)
   -c PARAM    - Send PARAM to ./configure
   -m PARAM    - Send PARAM to make
   -s          - Run 'make install' with sudo
                 (warning: might prompt for a password, depending on your
                  sudo configuration)

NOTES:
  1. When building from tarball, will use './configure && make && make check'
  2. When building from git, will add './bootstrap' as well.
  3. gz,bz2,xz compressions are supported.

Examples:

  # Download the tarball and run
  #   ./configure && make && make install
  $BASE http://ftp.gnu.org/gnu/datamash/datamash-1.0.7.tar.gz

  # run:
  #   git clone git://git.savannah.gnu.org/datamash.git &&
  #    cd datamash &&
  #      ./bootstrap &&
  #        ./configure &&
  #          make && make install
  $BASE git://git.savannah.gnu.org/datamash.git

  # Same with S3 file
  $BASE s3://mybucket/source/datamash-1.0.7.tar.gz

"
    exit 0
}


##
## Script starts here
##

## parse parameterse
show_help=
configure_params=
make_params=
git_branch=
upload_report_url=
sudo_param=
while getopts sr:b:c:m:h name
do
        case $name in
        b)      git_branch="-b '$OPTARG'"
                ;;
        c)      configure_params="$configure_params $OPTARG"
                ;;
        m)      make_params="$make_params $OPTARG"
                ;;
        h)      show_help=y
                ;;
        s)      sudo_param=sudo
                ;;
        ?)      die "Try -h for help."
        esac
done
[ ! -z "$show_help" ] && show_help_and_exit;

shift $((OPTIND-1))

SOURCE=$1
test -z "$SOURCE" \
    && die "missing SOURCE file name or URL " \
           "(e.g. http://ftp.gnu.org/gnu/coreutils/coreutils-8.23.tar.xz ). "\
           "Try -h for help."
shift 1

##
## Extract basename for the project, create temporary directory
##
BASENAME=$(basename "$SOURCE")
# Remove known extensions
BASENAME=${BASENAME%.git}
BASENAME=${BASENAME%.xz}
BASENAME=${BASENAME%.gz}
BASENAME=${BASENAME%.bz2}
BASENAME=${BASENAME%.tar}
validate_simple_name "$BASENAME"

##
## Create temporary working directory
##
# The '-t' syntax is deprecated by GNU coreutils, but this forms still
# works on all tested systems (non GNU as well)
DIR=$(mktemp -d -t "${BASENAME}.XXXXXX") \
    || die "failed to create temporary directory"

echo "Temp build directory = $DIR"

##
## Validate source (git, remote file, local file)
##
## Is the source a git repository or a local TARBALL file?
if echo "$SOURCE" | grep -E -q '^git://|\.git$' ; then
    ## a Git repository source
    cd "$DIR" || exit 1
    git ls-remote "$SOURCE" >/dev/null \
        || die "source ($SOURCE) is not a valid remote git repository"
    GIT_REPO=$SOURCE

elif echo "$SOURCE" | \
    grep -E -q '^(ht|f)tp://[A-Za-z0-9\_\.\/\~:-]*\.tar\.(gz|bz2|xz)' ; then
    ## a remote tarball source
    TMP1=$(basename "$SOURCE") || die "failed to get basename of '$SOURCE'"
    cd "$DIR" || exit 1
    wget -O "$TMP1" "$SOURCE" || die "failed to download '$SOURCE'"
    TARBALL="$TMP1"

elif echo "$SOURCE" | \
    grep -E -q '^s3://[A-Za-z0-9\_\.\/\~:-]*\.tar\.(gz|bz2|xz)' ; then
    ## an AWS/S3 remote tarball source
    TMP1=$(basename "$SOURCE") || die "failed to get basename of '$SOURCE'"
    cd "$DIR" || exit 1
    aws s3 cp "$SOURCE" "$TMP1" || die "failed to S3 download '$SOURCE'"
    TARBALL="$TMP1"

else
    ## assume a local tarball source
    [ -e "$SOURCE" ] || die "source file $SOURCE not found"
    cp "$SOURCE" "$DIR/" || die "failed to copy '$SOURCE' to '$DIR/'"
    cd "$DIR" || exit 1
    TARBALL=$(basename "$SOURCE") || exit 1
fi


##
## If it's a local file, determine compression type
##
if test -n "$TARBALL" ; then
  FILENAME=$(basename "$TARBALL" ) || exit 1
  EXT=${FILENAME##*.tar.}
  test "$EXT" = "gz" && COMPPROG=gzip
  test "$EXT" = "bz2" && COMPPROG=bzip2
  test "$EXT" = "xz" && COMPPROG=xz
  test -z "$COMPPROG" \
    && die "unknown compression extension ($EXT) in filename ($FILENAME)"
fi


##
## Extract the tarball (if needed)
##
## NOTE: about the convoluted 'cd' command:
##   Most release tarballs contain a sub-directory with the same name as
##   the tarball itself (e.g. 'grep-2.9.1-abcd.tar.gz' will contain
##   './grep-2.9.1-abcd/').
##   But few tarballs (especially alpha-stage and temporary ones send to
##   GNU platform-testers can contain other sub-directory names
##   (e.g. 'grep-2.9.1.tar.gz' might have './grep-ss' sub directory).
##   So use 'find' to find the first sub directory
##   (assuming there's only one).
if test -n "$TARBALL" ; then
    $COMPPROG -dc "$TARBALL" | tar -xf - \
        || die "failed to extract '$DIR/$TARBALL' (using $COMPPROG)"

    SRCDIR=$(find . -type d \! -name "logs" | grep -v '^\.$' | sort | head -n 1)
    test -d "$SRCDIR" || die "failed to find source directory after " \
                             "extracting '$DIR/$TARBALL'"
    cd "$SRCDIR" || die "failed to cd into '$SRCDIR'"
fi


##
## Clone the GIT repository (if needed)
##
need_bootstrap=0
if test -n "$GIT_REPO" ; then
    git clone $git_branch "$GIT_REPO" "$BASENAME" \
        || die "failed to clone '$GIT_REPO' to local directory '$BASENAME'"
    cd $BASENAME || die "failed to cd into '$BASENAME'"

    need_bootstrap=1
fi

##
## common building steps
##
status=""

## TODO:
## accomodate for optional 'autogen.sh' or similar scripts
if test "$need_bootstrap" -eq 1 && test -e "./bootstrap" ; then
    ./bootstrap \
        || die "./bootstrap failed"
fi

##
## Configure
##
if test -e "./configure" ; then
    ./configure $configure_params \
        || die "./configure failed"
fi

##
## Make
##
make $make_params \
    || die "make failed"

##
## Make Install
##
$sudo_param make install \
    || die "make install failed"

##
## All OK - delete temp directory
##
cd /tmp
rm -rf "$DIR"
