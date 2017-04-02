#!/bin/sh

DIR="/etc/pf-files"
CC="cn az by kz kg ru tj tm uz vn"

echo "blocked IP zones: `wc -l /etc/pf-files/blocked_zones|awk '{print $1}'`"

mv $DIR/blocked_zones $DIR/blocked_zones.bak
mv $DIR/zeus $DIR/zeus.bak


for x in $CC 
   do
	echo "Downloading ${x}.zone file"
	wget -q -4 --no-proxy --no-cookies --no-cache http://ipdeny.com/ipblocks/data/countries/${x}.zone -O $DIR/${x}.zone
	sleep 1
	cat ${x}.zone >> $DIR/blocked_zones
   done

echo "blocked IP zones: `wc -l /etc/pf-files/blocked_zones|awk '{print $1}'`"

echo "Downloading ZeuS IP blocklist"
wget -q -4 --no-proxy --no-cookies --no-cache \
https://zeustracker.abuse.ch/blocklist.php?download=badips -O $DIR/zeus

if [ ! -s $DIR/blocked_zones ]; then
        echo "Download NOT complete."
        exit 1
fi

if [ ! -s $DIR/zeus ]; then
        echo "Download NOT complete."
        exit 1
fi


echo "Download complete, reloading pf ruleset"
pfctl -nf /etc/pf.conf
echo "Done."
exit 0


wget -4 --no-proxy --no-cookies --no-cache \
	http://ipdeny.com/ipblocks/data/countries/cn.zone # CHINA
wget -4 --no-proxy --no-cookies --no-cache \
	http://ipdeny.com/ipblocks/data/countries/az.zone # AZERBAIJAN
wget -4 --no-proxy --no-cookies --no-cache \
	http://ipdeny.com/ipblocks/data/countries/by.zone # BELARUS
wget -4 --no-proxy --no-cookies --no-cache \
	http://ipdeny.com/ipblocks/data/countries/kz.zone # KAZAKHSTAN
wget -4 --no-proxy --no-cookies --no-cache \
	http://ipdeny.com/ipblocks/data/countries/kg.zone # KYRGYZSTAN
wget -4 --no-proxy --no-cookies --no-cache \
	http://ipdeny.com/ipblocks/data/countries/ru.zone # RUSSIAN FEDERATION
wget -4 --no-proxy --no-cookies --no-cache \
	http://ipdeny.com/ipblocks/data/countries/tj.zone # TAJIKISTAN
wget -4 --no-proxy --no-cookies --no-cache \
	http://ipdeny.com/ipblocks/data/countries/tm.zone # TURKMENISTAN
wget -4 --no-proxy --no-cookies --no-cache \
	http://ipdeny.com/ipblocks/data/countries/uz.zone # UZBEKISTAN
wget -4 --no-proxy --no-cookies --no-cache \
	http://ipdeny.com/ipblocks/data/countries/vn.zone # VIET NAM

cat cn.zone >  blocked_zones
cat az.zone >> blocked_zones
cat by.zone >> blocked_zones
cat kz.zone >> blocked_zones
cat kg.zone >> blocked_zones
cat ru.zone >> blocked_zones
cat tj.zone >> blocked_zones
cat tm.zone >> blocked_zones
cat uz.zone >> blocked_zones
cat vn.zone >> blocked_zones
