export PKG_PATH="http://ftp.openbsd.org/pub/OpenBSD/`uname -r`/packages/`machine -a`/"
echo "OpenBSD 6.4 release in `/usr/local/bin/openbsd.pl` :-)\n"
mesg n ; uname -a ; w ; echo ; df -hi ; echo ; quota -v
