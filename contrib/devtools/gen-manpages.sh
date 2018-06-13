#!/bin/bash

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

NEXOLD=${NEXOLD:-$BINDIR/nexold}
NEXOLCLI=${NEXOLCLI:-$BINDIR/nexol-cli}
NEXOLTX=${NEXOLTX:-$BINDIR/nexol-tx}
NEXOLQT=${NEXOLQT:-$BINDIR/qt/nexol-qt}

[ ! -x $NEXOLD ] && echo "$NEXOLD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
BTCVER=($($NEXOLCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for nexold if --version-string is not set,
# but has different outcomes for nexol-qt and nexol-cli.
echo "[COPYRIGHT]" > footer.h2m
$NEXOLD --version | sed -n '1!p' >> footer.h2m

for cmd in $NEXOLD $NEXOLCLI $NEXOLTX $NEXOLQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BTCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BTCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
