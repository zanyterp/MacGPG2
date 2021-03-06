require 'formula'

class Libusb < Formula
  url 'http://downloads.sourceforge.net/project/libusb/libusb-1.0/libusb-1.0.8/libusb-1.0.8.tar.bz2'
  homepage 'http://www.libusb.org/'
  md5 '37d34e6eaa69a4b645a19ff4ca63ceef'
  
  keep_install_names true
  
  def options
    [["--universal", "Build a universal binary."]]
  end
  
  def install
    ENV.universal_binary if ARGV.build_universal?
    # Make sure that deployment target is 10.6+ so the lib works
    # on 10.6 and up not only on host system os x version.
    ENV.macosxsdk("10.6")
    
    ENV.prepend 'LDFLAGS', '-headerpad_max_install_names'
    
    system "./configure", "--prefix=#{prefix}", 
           "--enable-static=no", "--disable-dependency-tracking"
    system "make check"
    system "make install"
  end
end
