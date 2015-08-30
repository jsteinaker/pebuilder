#!/bin/bash

# Environment variables
ARCH="x86"
LANGUAGE="es-ES"
ROOT="/home/javier/github/pebuilder"
PEROOT="$ROOT/winpe"
FILES="$ROOT/files"
BASEPE="/home/javier/winpe"

# Clean the destination directory, if exists.
rm -rf $PEROOT/$ARCH

# Copy base PE, as extracted from ADK with 'copype' command
cp -r $BASEPE/$ARCH $PEROOT/

# Mount image
wimlib-imagex mountrw $PEROOT/$ARCH/media/sources/boot.wim $PEROOT/$ARCH/mount

# Manual file copy (in this tree, we have scripts, tools, etc)
cp -r $FILES/$ARCH/* $PEROOT/$ARCH/mount

# Unmount image, saving changes
wimlib-imagex unmount /$PEROOT/$ARCH/mount --commit
