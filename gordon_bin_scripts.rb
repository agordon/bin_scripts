require 'formula'

class GordonBinScripts < Formula
  homepage 'https://github.com/agordon/bin_scripts'
  head 'https://github.com/agordon/bin_scripts.git'

  if build.head?
    depends_on :autoconf => :build
    depends_on :automake => :build
  end

  def install

    if build.head?
      # Ugly hack: The build system extracts the version from either ".git" (if cloned)
      #            or from ".tarball-version" (if from a proper dist tarball).
      #            But here, HomeBrew clones (shallowly) first, then extract to a separate directory,
      #            So there's neither ".git" nor ".tarball-version".
      #
      #            Here, we go back to the GIT directory, 'unshallow' the repository
      #            (unshallow requires git version 1.8.3 or later), then extract the version.
      #            If 'unshallowing' failed, fallback to the SHA1 of the current version.
      ohai "Trying to extract version from Git Repository"
      git_repo = "#{HOMEBREW_CACHE}/#{name}--git"
      prog_version = `(cd #{git_repo} ; git fetch --unshallow ; ./config/git-version-gen v )`
      prog_version.chomp!
      if prog_version == "UNKNOWN"
        git_version = `(cd #{git_repo} ; git describe --always )`
        git_version.chomp!
        prog_version = "0.0.0-#{git_version}-HomeBrew-Git"
      end
      ohai "Detected Git version = #{prog_version}"
      system "echo '#{prog_version}' > .tarball-version"
    end
    system 'sh', './bootstrap.sh'
    system './configure', "--prefix=#{prefix}"
    system 'make'
    system 'make', 'install'
  end
end
