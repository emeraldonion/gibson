PREFIX?=/usr/local
DST=    ${DESTDIR}${PREFIX}

all:

install:
	mkdir -p ${DST}/etc/gibson ${DST}/man/man5 ${DST}/man/man7 ${DST}/bin ${DST}/share/gibson
	cp -R share/ ${DST}/share/gibson/
	cp gibson ${DST}/bin/
	cp gibson.conf.sample ${DST}/etc/gibson.conf.sample
	cp gibson.conf.sample ${DST}/etc/gibson.conf
	chmod 755 ${DST}/bin/gibson
	chmod 755 ${DST}/share/gibson/*
