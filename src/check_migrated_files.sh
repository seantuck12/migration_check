#!/bin/bash
# Sean Tuck, 2020-06-16

# Create migration certificate and check for failed file migrations
# ===================================================================
# To be run in new VRE.
# The migrated files are validated against the file catalog created
# in the old VRE, using sha256 check - the check's output forms the
# migration certificate. File checksums which don't match that given
# in the file catalog are tagged as FAILED (otherwise OK). Any failed 
# migrations are also logged in a separate file for easier examination.
# ===================================================================
# RETURNS: 
# - Migration certificate: File paths in catalog with OK/FAILED check status.
# - Stdout reporting migration success
# - If any failures exist, a text file logging failed file migrations.

# Need to add checks that:
# - No old VRE files which don't exist in new VRE
# - No new VRE files which didn't exist in old VRE

FILELIST=project_files_catalog.txt
CERTIFICATE=migration_certificate.txt
FAIL_LOG=failed_migrations.txt

function check_migrated_files
{
	grep -vP "($FILELIST)|($CERTIFICATE)" $FILELIST | sha256sum -c > $CERTIFICATE
	
	local FAILURES=`grep '\: FAILED$' ./$CERTIFICATE`
	local NUM_FAILED=`$FAILURES | wc -l`

	if [ $NUM_FAILED -gt 0 ]
	then
		echo "Found $NUM_FAILED file(s) that don't match original(s)."
		echo "See $FAIL_LOG"
		$FAILURES > $FAIL_LOG
	else
		echo "Migration successful. All files match original checksums."
	fi

}
