library CMS143FHIRPOAGOpticNerveEval version '0.2.000'

using QICore version '6.0.0'

/*
Notes 
1. 8/09.2023: Per BonnieMat-1455 and ticket  https://github.com/cqframework/cql-execution/issues/296 
*/


include FHIRHelpers version '4.4.000' called FHIRHelpers
include SupplementalDataElements version '5.1.000' called SDE
include QICoreCommon version '4.0.000' called QICoreCommon

codesystem "ActCode": 'http://terminology.hl7.org/CodeSystem/v3-ActCode'

valueset "Care Services in Long-Term Residential Facility": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1014'
valueset "Cup to Disc Ratio": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1333'
valueset "Medical Reason": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1007'
valueset "Nursing Facility Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1012'
valueset "Office Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1001'
valueset "Ophthalmological Services": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1285'
valueset "Optic Disc Exam for Structural Abnormalities": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1334'
valueset "Outpatient Consultation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1008'
valueset "Primary Open-Angle Glaucoma": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.326'

code "virtual": 'VR' from "ActCode" display 'virtual'

parameter "Measurement Period" Interval<DateTime>

context Patient

define "SDE Ethnicity":
  SDE."SDE Ethnicity"

define "SDE Payer":
  SDE."SDE Payer"

define "SDE Race":
  SDE."SDE Race"

define "SDE Sex":
  SDE."SDE Sex"

define "Denominator":
  "Initial Population"

define "Denominator Exceptions":
  exists "Medical Reason for Not Performing Cup to Disc Ratio"
    or exists "Medical Reason for Not Performing Optic Disc Exam"

define "Qualifying Encounter During Measurement Period":
  ( ["Encounter": "Office Visit"]
    union ["Encounter": "Ophthalmological Services"]
    union ["Encounter": "Outpatient Consultation"]
    union ["Encounter": "Nursing Facility Visit"]
    union ["Encounter": "Care Services in Long-Term Residential Facility"] ) QualifyingEncounter
    where QualifyingEncounter.period during day of "Measurement Period"
      and QualifyingEncounter.status = 'finished'
      and QualifyingEncounter.class !~ "virtual"

define "Initial Population":
  AgeInYearsAt(date from start of "Measurement Period") >= 18
    and exists "Primary Open Angle Glaucoma Encounter"

define "Primary Open Angle Glaucoma Encounter":
  "Qualifying Encounter During Measurement Period" ValidQualifyingEncounter
    with (["ConditionProblemsHealthConcerns": "Primary Open-Angle Glaucoma"]
    union ["ConditionEncounterDiagnosis": "Primary Open-Angle Glaucoma"]) PrimaryOpenAngleGlaucoma
      such that PrimaryOpenAngleGlaucoma.prevalenceInterval() overlaps ValidQualifyingEncounter.period
        and not ( PrimaryOpenAngleGlaucoma.verificationStatus ~ QICoreCommon."unconfirmed"
            or PrimaryOpenAngleGlaucoma.verificationStatus ~ QICoreCommon."refuted"
            or PrimaryOpenAngleGlaucoma.verificationStatus ~ QICoreCommon."entered-in-error"
        )

define "Cup to Disc Ratio Performed with Result":
  ["ObservationClinicalResult": "Cup to Disc Ratio"] CupToDiscExamPerformed
    with "Primary Open Angle Glaucoma Encounter" EncounterWithPOAG
      such that CupToDiscExamPerformed.effective.toInterval() during day of EncounterWithPOAG.period
    where CupToDiscExamPerformed.value is not null
      and CupToDiscExamPerformed.status in { 'final', 'amended', 'corrected' }

define "Optic Disc Exam Performed with Result":
  ["ObservationClinicalResult": "Optic Disc Exam for Structural Abnormalities"] OpticDiscExamPerformed
    with "Primary Open Angle Glaucoma Encounter" EncounterWithPOAG
      such that OpticDiscExamPerformed.effective.toInterval() during EncounterWithPOAG.period
    where OpticDiscExamPerformed.value is not null
      and OpticDiscExamPerformed.status in { 'final', 'amended', 'corrected' }

define "Numerator":
  exists "Cup to Disc Ratio Performed with Result"
    and exists "Optic Disc Exam Performed with Result"

define "Medical Reason for Not Performing Cup to Disc Ratio":
  ["ObservationCancelled": "Cup to Disc Ratio"] CupToDiscExamNotPerformed
    with "Primary Open Angle Glaucoma Encounter" EncounterWithPOAG
      such that CupToDiscExamNotPerformed.issued during day of EncounterWithPOAG.period
    where CupToDiscExamNotPerformed.notDoneReason in "Medical Reason"

define "Medical Reason for Not Performing Optic Disc Exam":
  ["ObservationCancelled": "Optic Disc Exam for Structural Abnormalities"] OpticDiscExamNotPerformed
    with "Primary Open Angle Glaucoma Encounter" EncounterWithPOAG
      such that OpticDiscExamNotPerformed.issued during day of EncounterWithPOAG.period
    where OpticDiscExamNotPerformed.notDoneReason in "Medical Reason"