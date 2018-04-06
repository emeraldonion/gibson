#!/bin/sh
#
# Copyright (c) 2018, Emerald Onion
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#  list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#  this list of conditions and the following disclaimer in the documentation
#  and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# Import common
. /usr/local/share/gibson/common

usage() {
	cat <<EOF
Usage: gibson command [options] [jailname ...] <command>

EOF
	exit 1
}

jail_command()
{
	local jailname
	jailname=$1
	shift
	debug "${jailname}: $*..."
	jexec ${jailname} sh -c "$*"
}

while getopts ":t:v" OPTION; do
	case "${OPTION}" in
	v)
		VERBOSE=1
		;;
	*)
		usage
		;;
	esac
done
shift $((OPTIND-1))

JAILS=""
while [ ! -z "${1}" ] && [ -d ${JAILS_PATH}/${1} ]; do
	JAILS="${JAILS} ${1}"
	shift
done

if [ -z "${JAILS}" ]; then
	JAILS=$(ls ${JAILS_PATH} | grep -v templates)
fi

for jailname in ${JAILS}; do
	jail_command ${jailname} $*
done
