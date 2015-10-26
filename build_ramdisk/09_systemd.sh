#!/bin/bash
#
# Copyright (c) 2013, 2014 Plat'Home CO., LTD.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY PLAT'HOME CO., LTD. AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL PLAT'HOME CO., LTD. AND CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

. `dirname $0`/config.sh

[ "${TARGET}" == "obs600" ] && exit

if [ ${DIST} == "jessie" ]; then

SYSTEMDDIR=${DISTDIR}/lib/systemd/system

	ret=`grep -q openblocks-setup ${DISTDIR}/etc/init.d/networking` 
	if [ $? == 1 ]; then
		sed -e "s|urandom|urandom openblocks-setup|" \
			< ${DISTDIR}/etc/init.d/networking > /tmp/networking.new
		mv -f /tmp/networking.new ${DISTDIR}/etc/init.d/networking
		chmod 555 ${DISTDIR}/etc/init.d/networking
	fi

#	sed -e "s|hwclock -D --systohc|hwclock --systohc|" \
#		< ${SYSTEMDDIR}/hwclock-save.service > /tmp/hwclock-save.service.new
#	mv -f /tmp/hwclock-save.service.new ${SYSTEMDDIR}/hwclock-save.service

	# runled
	cp -a ${FILESDIR}/systemd/plathome-runled.service ${SYSTEMDDIR}
	(cd ${DISTDIR}/etc/systemd/system/multi-user.target.wants; \
		ln -sf /lib/systemd/system/plathome-runled.service runled.service)

	# pshd
	cp -a ${FILESDIR}/systemd/plathome-pshd.service ${SYSTEMDDIR}
	(cd ${DISTDIR}/etc/systemd/system/multi-user.target.wants; \
		ln -sf /lib/systemd/system/plathome-pshd.service pshd.service)
fi
