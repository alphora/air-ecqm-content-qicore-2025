library CMS142FHIRCommWithDrManagingDiab version '0.2.000'

using QICore version '6.0.0'

/*
Notes: 
- Per BonnieMat-1455 and ticket  https://github.com/cqframework/cql-execution/issues/296  
--https://oncprojectracking.healthit.gov/support/browse/CQLIT-371 (formerly BonnieMat-1420)
--surrounding negation with QI-Core 4.1.1 DRC are not supported as resource filters and must be replaced with valueset or used on unfiltered resource in predicate
--cardinality issues surrounding negation coding to be addressed in future execution engine update
*/

include FHIRHelpers version '4.4.000' called FHIRHelpers
include SupplementalDataElements version '5.1.000' called SDE
include QICoreCommon version '4.0.000' called QICoreCommon

codesystem "SNOMEDCT": 'http://snomed.info/sct'
codesystem "ActCode": 'http://terminology.hl7.org/CodeSystem/v3-ActCode'

valueset "Care Services in Long-Term Residential Facility": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1014'
valueset "Diabetic Retinopathy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.327'
valueset "Level of Severity of Retinopathy Findings": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1283'
valueset "Macular Edema Findings Present": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1320'
valueset "Macular Exam": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1251'
valueset "Medical Reason": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1007'
valueset "Nursing Facility Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1012'
valueset "Office Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1001'
valueset "Ophthalmological Services": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1285'
valueset "Outpatient Consultation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1008'
valueset "Patient Reason": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1008'
valueset "Macular Edema Findings Absent": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.2.1391'

code "virtual": 'VR' from "ActCode" display 'virtual'
// code "Macular edema absent (situation)": '428341000124108' from "SNOMEDCT" display 'Macular edema absent (situation)'

code "AMB": 'AMB' from "ActCode" display 'Ambulatory'

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

define "Initial Population":
  AgeInYearsAt(date from start of "Measurement Period") >= 18
    and exists "Diabetic Retinopathy Encounter"

define "Denominator":
  "Initial Population"
    and exists "Macular Exam Performed"

define "Numerator":
  exists "Level of Severity of Retinopathy Findings Communicated"
    and ( exists "Macular Edema Absence Communicated"
        or exists "Macular Edema Presence Communicated"
    )

define "Denominator Exceptions":
  exists "Medical or Patient Reason for Not Communicating Level of Severity of Retinopathy"
    or exists "Medical or Patient Reason for Not Communicating Absence of Macular Edema"
    or exists "Medical or Patient Reason for Not Communicating Presence of Macular Edema"

define "Qualifying Encounter During Day of Measurement Period":
  ( ["Encounter": "Office Visit"]
    union ["Encounter": "Ophthalmological Services"]
    union ["Encounter": "Outpatient Consultation"]
    union ["Encounter": "Care Services in Long-Term Residential Facility"]
    union ["Encounter": "Nursing Facility Visit"] ) QualifyingEncounter
    where QualifyingEncounter.period during day of "Measurement Period"
      and QualifyingEncounter.status = 'finished'
      and QualifyingEncounter.class !~ "virtual"

define "Diabetic Retinopathy Encounter":
  "Qualifying Encounter During Day of Measurement Period" ValidQualifyingEncounter
    with (["ConditionProblemsHealthConcerns": "Diabetic Retinopathy"]
     union ["ConditionEncounterDiagnosis": "Diabetic Retinopathy"] ) DiabeticRetinopathy
      such that DiabeticRetinopathy.prevalenceInterval ( ) overlaps day of ValidQualifyingEncounter.period
        and not ( DiabeticRetinopathy.verificationStatus ~ QICoreCommon."unconfirmed"
            or DiabeticRetinopathy.verificationStatus ~ QICoreCommon."refuted"
            or DiabeticRetinopathy.verificationStatus ~ QICoreCommon."entered-in-error"
        )

define "Macular Exam Performed":
  ["ObservationClinicalResult": "Macular Exam"] MacularExam
    with "Diabetic Retinopathy Encounter" EncounterDiabeticRetinopathy
      such that MacularExam.effective.toInterval ( ) during EncounterDiabeticRetinopathy.period
    where MacularExam.value is not null
      and MacularExam.status in { 'final', 'amended', 'corrected', 'preliminary' }

define "Results of Dilated Macular or Fundus Exam Communicated":
  exists "Level of Severity of Retinopathy Findings Communicated"
    and ( exists "Macular Edema Absence Communicated"
        or exists "Macular Edema Presence Communicated"
    )

define "Level of Severity of Retinopathy Findings Communicated":
  ["Communication": category in "Level of Severity of Retinopathy Findings"] LevelOfSeverityCommunicated
    with "Diabetic Retinopathy Encounter" EncounterDiabeticRetinopathy
      such that LevelOfSeverityCommunicated.sent after start of EncounterDiabeticRetinopathy.period
        and LevelOfSeverityCommunicated.sent during day of "Measurement Period"
    where LevelOfSeverityCommunicated.status = 'completed'

define "Macular Edema Absence Communicated":
  ["Communication": category in "Macular Edema Findings Absent"] MacularEdemaAbsentCommunicated
    with "Diabetic Retinopathy Encounter" EncounterDiabeticRetinopathy
      such that MacularEdemaAbsentCommunicated.sent after start of EncounterDiabeticRetinopathy.period
        and MacularEdemaAbsentCommunicated.sent during day of "Measurement Period"
    where MacularEdemaAbsentCommunicated.status = 'completed'

define "Macular Edema Presence Communicated":
  ["Communication": category in "Macular Edema Findings Present"] MacularEdemaPresentCommunicated
    with "Diabetic Retinopathy Encounter" EncounterDiabeticRetinopathy
      such that MacularEdemaPresentCommunicated.sent after start of EncounterDiabeticRetinopathy.period
        and MacularEdemaPresentCommunicated.sent during day of "Measurement Period"
    where MacularEdemaPresentCommunicated.status = 'completed'

define "Medical or Patient Reason for Not Communicating Level of Severity of Retinopathy":
  [CommunicationNotDone: category in "Level of Severity of Retinopathy Findings"] LevelOfSeverityNotCommunicated
    with "Diabetic Retinopathy Encounter" EncounterDiabeticRetinopathy
      such that LevelOfSeverityNotCommunicated.recorded during EncounterDiabeticRetinopathy.period
    where ( LevelOfSeverityNotCommunicated.statusReason in "Medical Reason"
        or LevelOfSeverityNotCommunicated.statusReason in "Patient Reason"
    )

define "Medical or Patient Reason for Not Communicating Presence of Macular Edema":
  [CommunicationNotDone: category in "Macular Edema Findings Present"] MacularEdemaPresentNotCommunicated
    with "Diabetic Retinopathy Encounter" EncounterDiabeticRetinopathy
      such that MacularEdemaPresentNotCommunicated.recorded during EncounterDiabeticRetinopathy.period
    where ( MacularEdemaPresentNotCommunicated.statusReason in "Medical Reason"
        or MacularEdemaPresentNotCommunicated.statusReason in "Patient Reason"
    ) 

/* Note: 
below definition workaround for 
https://oncprojectracking.healthit.gov/support/browse/CQLIT-371. Using value set workaround has been applied for now
but when QI Core STU 5 gets in the tool, it may be reverted back to a DRC */
define "Medical or Patient Reason for Not Communicating Absence of Macular Edema":
  [CommunicationNotDone: category in "Macular Edema Findings Absent"] MacularEdemaAbsentNotCommunicated
    with "Diabetic Retinopathy Encounter" EncounterDiabeticRetinopathy
      such that MacularEdemaAbsentNotCommunicated.recorded during EncounterDiabeticRetinopathy.period
    where ( MacularEdemaAbsentNotCommunicated.statusReason in "Medical Reason"
        or MacularEdemaAbsentNotCommunicated.statusReason in "Patient Reason"
    )