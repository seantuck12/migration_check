#!/bin/bash
# Sean Tuck, 2020-06-16

# Finds all files within directory tree and their checksums.
# ================================================================
# The search begins in the folder containing the migration repo
# (project root) and includes all files except the migration repo.
# Files identified by their relative paths from project root.
# Using relative paths here means that the new VREs directory tree
# need only be identical from the point of the project root.
# ================================================================
# RETURNS: A text file named $FILELIST including the relative path
# of every file and its sha256 checksum.

FILELIST=project_files_catalog.txt

function get_files_catalog
{
	local DIRTREE="./"
	local REPO="./migration_check*"

	find "$DIRTREE" -not -path "$REPO" -type f -exec sha256sum {} + > $FILELIST
}
