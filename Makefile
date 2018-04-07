PREFIX?=/usr/local
DST=    ${DESTDIR}${PREFIX}

all:

install:
	mkdir -p ${DST}/etc/gibson ${DST}/man/man5 ${DST}/man/man8 ${DST}/bin ${DST}/share/gibson
	cp -R share/ ${DST}/share/gibson/
	cp gibson ${DST}/bin/
	cp gibson.conf.sample ${DST}/etc/gibson.conf.sample
	cp gibson.conf.sample ${DST}/etc/gibson.conf
	cp gibson.8 ${DST}/man/man8/
	cp gibson.conf.5 ${DST}/man/man5/
	chmod 755 ${DST}/bin/gibson
	chmod 755 ${DST}/share/gibson/*
