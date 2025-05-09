#!/bin/bash
#DO NOT EDIT WITH WINDOWS

usage () {
    cat <<HELP_USAGE

    $0  [-d] [-s <fhir_base_url>] [-u]

   Refreshes FHIR documents in place. Optionally loads resources to a FHIR server.

   -h  Print this help
   -d  Use default Alphora FHIR sandbox.  Mutually exclusive with -s.
   -s  Use specificed fhir base url like http://localhost:8080/fhir/.  Mutually exclusive with -d.
   -u  Unattended mode.  Defaults to false.
HELP_USAGE
	exit 0
}

tooling_jar=tooling-cli-3.6.0.jar
input_cache_path=./input-cache
patient_id="ALL_PATIENTS"
measure_id="FootAssessmentAndFollowUp"

while getopts ":p:u" flag;
do
    case "${flag}" in
		p ) patient_id=$OPTARG;;
		m ) measure_id=$OPTARG;;
		u ) unattended=true;;
    esac
done

tooling=$input_cache_path/$tooling_jar
 if test -f "$tooling"; then
 	echo "running: java -jar $tooling -BundleToResources measure_id=${measure_id} patient_id=${patient_id}"
	mv bundles/${patient_id}/*.json bundles/${patient_id}/${patient_id}.json
 	java -jar $tooling -BundleToResources -p=bundles/${patient_id}/${patient_id}.json -e=json -op=./input/tests/measure/${measure_id}/${patient_id}
 else
 	tooling=../$tooling_jar
 	echo $tooling
 	if test -f "$tooling"; then
 		echo IG Refresh NOT FOUND in input-cache or parent folder.  Please run _updateCQFTooling.  Aborting...
 	fi
 fi

if [ "$unattended" = false ] ; then
	read -p "Press any key to resume ..."
fi