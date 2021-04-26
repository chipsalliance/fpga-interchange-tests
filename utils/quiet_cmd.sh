#!/bin/bash -e
# Copyright (C) 2021  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

if [[ $VERBOSE -gt 0 ]]; then
  set -x
fi

OUTPUT=$(mktemp $(basename $1).output.XXX)

set +e
"$@" > $OUTPUT 2>&1
RESULT=$?
set -e
if [[ $RESULT -ne 0 ]]  || [[ $VERBOSE -gt 0 ]]; then
  cat $OUTPUT
fi
rm $OUTPUT
exit $RESULT
