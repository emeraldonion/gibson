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
Usage: gibson update [options]

Options:
	-t directory	-- Use the update files saved in <directory>, rather than
			   downloading them again.  You might pre-fetch these by
			   invoking: hbsd-update -f -T -t <directory>

	-v		-- Be verbose
EOF
	exit 1
}

jail_update()
{
	local jailname
	jailname=$1
	shift
	echo "Applying updates: ${jailname}..."
	hbsd-update -D -T -t ${DIRECTORY} -j ${jailname} ${our_verbosity}
}

updates_directory()
{
	if [ -z "${DIRECTORY}" ] || [ ! -d ${DIRECTORY} ]; then
		our_update_folder=$(basename $(mktemp -d /tmp/gibson.XXXXXX))
		if [ $? -ne 0 ]; then
			echo "Cannot create temporary directory, exiting..."
			exit 1
		fi
		DIRECTORY="/tmp/${our_update_folder}"
		debug "Directory does not exist, making temporary directory ${DIRECTORY} and downloading updates..."
		echo "Fetching updates..."
		hbsd-update -i -t ${DIRECTORY} -T -f ${our_verbosity}
	else
		debug "Using existing updates directory: ${DIRECTORY}"
	fi
}

updates_directory_cleanup()
{
	if [ ! -z "${our_update_folder}" ]; then
		debug "Cleaning up temporary directory: ${DIRECTORY}"
		# We know that the variable isn't empty, so this should be safe enough...
		rm -rf /tmp/${our_update_folder}/*
		rmdir /tmp/${our_update_folder}/
	fi
}

while getopts ":t:v" OPTION; do
	case "${OPTION}" in
	t)
		DIRECTORY=${OPTARG}
		;;
	v)
		VERBOSE=1
		;;
	*)
		usage
		;;
	esac
done
shift $((OPTIND-1))

if [ -z "${VERBOSE}" ]; then
	our_verbosity=">/dev/null 2>&1"
else
	our_verbosity=""
fi

JAILS=""
while [ ! -z "${1}" ] && [ -d ${JAILS_PATH}/${1} ]; do
	JAILS="${JAILS} ${1}"
	shift
done

if [ "${JAILS}" = "" ]; then
	JAILS=$(ls ${JAILS_PATH} | grep -v templates)
fi

updates_directory
for jailname in ${JAILS}; do
	jail_update ${jailname}
done
updates_directory_cleanup
