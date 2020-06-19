# LIDA Project VRE Migration Checks

LIDA will be migrating projects from the old secure research platform (IRC) to the new platform (LASER).

This repo includes bash scripts to catalog all files within a VRE before migration and then check the migrated files in the new VRE, to make sure that the project's migration has been successful.

A project's migration is successful if the directory tree, relative from the project root, is identical in both old and new platforms and all files within have equivalent contents as measured by SHA256 checksums.

## Migration instructions

1. Log on to the IRC Gate

2. Open Git Bash

3. Change directory (`cd`) to the root folder for the project you are migrating

4. Copy this repo to the project root using:
- `git --clone <URL>`

5. `cd ./migration_check/`

6. Catalog all files in the VRE using:
- `bash get_project_catalog.sh`

7. Zip all contents within the project root folder (but not the project root itself)

8. Send the zip file to team mailbox via SFT, for download in Azure

9. Go to Azure

10. Download zip file to new VRE filespace via BisCom

11. Extract files to new project root folder
- If you zipped the project root earlier, the new directory tree will be root/root/* and therefore won't be identical to old VRE

12. Open Git Bash

13. Change directory to migration_check folder

14. Check migrated files against the old VRE's project catalog using:
- `bash check_migrated_files.sh`

15. Read the output. If any file migrations failed, check the log file (failed_migrations.txt) and retry the files listed within.
