library CMS75FHIRChildrenWhoHaveDentalDecayOrCavities version '1.1.000'

using QICore version '6.0.0'

include FHIRHelpers version '4.4.000' called FHIRHelpers
include SupplementalDataElements version '5.1.000' called SDE
include QICoreCommon version '4.0.000' called QICoreCommon
include Hospice version '6.15.000' called Hospice

valueset "Clinical Oral Evaluation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.125.12.1003'
valueset "Dental Caries": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.125.12.1004'

parameter "Measurement Period" Interval<DateTime>

context Patient

define "Initial Population":
  AgeInYearsAt(date from start of "Measurement Period") in Interval[1, 20]
    and exists ( "Qualifying Encounters" )

define "Qualifying Encounters":
  ( ( [Encounter: "Clinical Oral Evaluation"] ).isEncounterPerformedLocal ( ) ) ValidEncounter
    where ValidEncounter.period during day of "Measurement Period"

define "Denominator":
  "Initial Population"

define "Denominator Exclusions":
  Hospice."Has Hospice Services"

define "Numerator":
  exists ( [ConditionProblemsHealthConcerns: "Dental Caries"]
    union [ConditionEncounterDiagnosis: "Dental Caries"] ) DentalCaries
    where DentalCaries.prevalenceInterval ( ) overlaps day of "Measurement Period"

define "SDE Ethnicity":
  SDE."SDE Ethnicity"

define "SDE Payer":
  SDE."SDE Payer"

define "SDE Race":
  SDE."SDE Race"

define "SDE Sex":
  SDE."SDE Sex"

define fluent function isEncounterPerformedLocal(Enc List<Encounter>):
  Enc E
    where E.status in { 'finished', 'in-progress' }