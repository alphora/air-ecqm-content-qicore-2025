library CMS74FHIRPrimaryCariesPreventionasOfferedbyDentists version '1.1.000'

using QICore version '6.0.0'

include FHIRHelpers version '4.4.000' called FHIRHelpers
include SupplementalDataElements version '5.1.000' called SDE
include QICoreCommon version '4.0.000' called QICoreCommon
include Hospice version '6.15.000' called Hospice
include Status version '1.13.000' called Status

valueset "Clinical Oral Evaluation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.125.12.1003'
valueset "Discharged to Health Care Facility for Hospice Care": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.207'
valueset "Discharged to Home for Hosice Care": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.209'
valueset "Encounter Inpatient": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.5.307'
valueset "Fluoride Varnish Application for Children": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.125.12.1002'

parameter "Measurement Period" Interval<DateTime>

context Patient

define "Initial Population":
  AgeInYearsAt(date from start of "Measurement Period") in Interval[1, 20]
    and exists ( "Qualifying Encounters" )

define "Qualifying Encounters":
  ( ( [Encounter: "Clinical Oral Evaluation"] ).isEncounterPerformedLocal() ) ValidEncounter
    where ValidEncounter.period during day of "Measurement Period"

define "Denominator":
  "Initial Population"

define "Denominator Exclusions":
  Hospice."Has Hospice Services"

define "Numerator":
  Count((([Procedure: "Fluoride Varnish Application for Children"]).isProcedurePerformed()) FluorideApplication
      where FluorideApplication.performed.toInterval() ends during day of "Measurement Period"
      return distinct date from 
      end of FluorideApplication.performed.toInterval()
  ) >= 2

define fluent function isEncounterPerformedLocal(Enc List<Encounter>):
  Enc E
    where E.status in {'finished', 'in-progress'}

define "Stratification 1":
  AgeInYearsAt(date from start of "Measurement Period") in Interval[1, 5]

define "Stratification 2":
  AgeInYearsAt(date from start of "Measurement Period") in Interval[6, 12]

define "Stratification 3":
  AgeInYearsAt(date from start of "Measurement Period") in Interval[13, 20]

define "SDE Ethnicity":
  SDE."SDE Ethnicity"

define "SDE Payer":
  SDE."SDE Payer"

define "SDE Race":
  SDE."SDE Race"

define "SDE Sex":
  SDE."SDE Sex"