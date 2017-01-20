#!/usr/bin/env bash
UPDATESAUR=$(cower -u | wc -l)
UPDATESPAC=$(checkupdates | wc -l)
#[[ "${UPDATESPAC}" = "0" ]] && exit 0
#[[ "${UPDATESAUR}" = "0" ]] && exit 0

echo "   PAC: ${UPDATESPAC} AUR: ${UPDATESAUR} "
exit 0
