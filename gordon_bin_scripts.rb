require 'formula'

class GordonBinScripts < Formula
  homepage 'https://github.com/agordon/bin_scripts'
  head 'https://github.com/agordon/bin_scripts.git'

  if build.head?
    depends_on :autoconf => :build
    depends_on :automake => :build
  end

  def install
      system 'sh', './bootstrap.sh'
      system './configure', "--prefix=#{prefix}"
      system 'make'
      system 'make', 'install'
  end
end
