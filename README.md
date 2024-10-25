# IG builds

- The default (master branch) can be found here: https://build.fhir.org/ig/HL7/phenomics-exchange-ig/
  - The build log for a successful build is here: https://build.fhir.org/ig/HL7/phenomics-exchange-ig/build.log
  - The build log for a failed build is here: https://build.fhir.org/ig/HL7/phenomics-exchange-ig/failure/build.log
- For branch specific builds, see here: https://build.fhir.org/ig/HL7/phenomics-exchange-ig/branches
  - Build logs are as described above for the default branch build.

- The IG as it appeared at the end of 2022 can be seen here: https://build.fhir.org/ig/HL7/phenomics-exchange-ig/branches/v0.1.0
  - It can be checked out by checking out the identically named tag `v0.1.0`.
- 

Use `./build.sh` to perform a local and Docker-based build. This will use the latest Publisher version as long as the Docker image for that version was successfully built (see [here](https://hub.docker.com/r/sessaid/ig-publisher/tags)). Also, it will use the Sushi version specified in the `/fsh.ini` file.
