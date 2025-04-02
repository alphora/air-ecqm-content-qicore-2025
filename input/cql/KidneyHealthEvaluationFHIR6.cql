library KidneyHealthEvaluationFHIR6 version '0.1.000'

using QICore version '6.0.0'

include FHIRHelpers version '4.4.000' called FHIRHelpers
include SupplementalDataElements version '5.1.000' called SDE
include QICoreCommon version '4.0.000' called QICoreCommon
include CQMCommon version '4.1.000' called CQMCommon
include Hospice version '6.14.000' called Hospice
include PalliativeCare version '1.13.000' called PalliativeCare

codesystem "SNOMEDCT": 'http://snomed.info/sct'
codesystem "ActCode": 'http://terminology.hl7.org/CodeSystem/v3-ActCode'
codesystem "ConditionClinicalStatusCodes": 'http://terminology.hl7.org/CodeSystem/condition-clinical'

valueset "Acute Inpatient": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1083'
valueset "Annual Wellness Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1240'
valueset "Chronic Kidney Disease, Stage 5": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1002'
valueset "Diabetes": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.103.12.1001'
valueset "Encounter Inpatient": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.5.307'
valueset "End Stage Renal Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.353'
valueset "Estimated Glomerular Filtration Rate": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.6929.3.1000'
valueset "Home Healthcare Services": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1016'
valueset "Hospice Care Ambulatory": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1584'
valueset "Office Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1001'
valueset "Outpatient Consultation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1008'
valueset "Palliative or Hospice Care": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.600.1.1579'
valueset "Preventive Care Services Established Office Visit, 18 and Up": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1025'
valueset "Preventive Care Services Initial Office Visit, 18 and Up": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1023'
valueset "Telephone Visits": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1080'
valueset "Urine Albumin Creatinine Ratio": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.6929.3.1007'

code "Discharge to healthcare facility for hospice care (procedure)": '428371000124100' from "SNOMEDCT" display 'Discharge to healthcare facility for hospice care (procedure)'
code "Discharge to home for hospice care (procedure)": '428361000124107' from "SNOMEDCT" display 'Discharge to home for hospice care (procedure)'
code "AMB": 'AMB' from "ActCode" display 'Ambulatory'
code "active": 'active' from "ConditionClinicalStatusCodes"

parameter "Measurement Period" Interval<DateTime>

context Patient

define "Initial Population":
  AgeInYearsAt(date from start of "Measurement Period") in Interval[18, 75]
    and "Has Active Diabetes Overlaps Measurement Period"
    and "Has Outpatient Visit During Measurement Period"

define "Denominator":
  "Initial Population"

define "Denominator Exclusions":
  exists "Has CKD Stage 5 or ESRD Diagnosis Overlaps Measurement Period"
    or Hospice."Has Hospice Services"
    or PalliativeCare."Has Palliative Care in the Measurement Period"

define "Numerator":
  "Has Kidney Panel Performed During Measurement Period"

define "Has Kidney Panel Performed During Measurement Period":
  exists ( ["LaboratoryResultObservation": "Estimated Glomerular Filtration Rate"] eGFRTest
      where eGFRTest.effective.toInterval ( ) during day of "Measurement Period"
        and eGFRTest.value is not null
        and eGFRTest.status in { 'final', 'amended', 'corrected' }
  )
    and exists ( ["LaboratoryResultObservation": "Urine Albumin Creatinine Ratio"] uACRTest
        where uACRTest.effective.toInterval ( ) during day of "Measurement Period"
          and uACRTest.value is not null
          and uACRTest.status in { 'final', 'amended', 'corrected' }
    )

define "Has Outpatient Visit During Measurement Period":
  exists ( ( ["Encounter": "Annual Wellness Visit"]
      union ["Encounter": "Home Healthcare Services"]
      union ["Encounter": "Office Visit"]
      union ["Encounter": "Outpatient Consultation"]
      union ["Encounter": "Preventive Care Services Established Office Visit, 18 and Up"]
      union ["Encounter": "Preventive Care Services Initial Office Visit, 18 and Up"]
      union ["Encounter": "Telephone Visits"] ) ValidEncounter
      where ValidEncounter.period during "Measurement Period"
        and ValidEncounter.status = 'finished'
  )

define "Has Active Diabetes Overlaps Measurement Period":
  exists ( (["ConditionProblemsHealthConcerns": "Diabetes"] union ["ConditionEncounterDiagnosis": "Diabetes"]) DiabetesDB
      where DiabetesDB.prevalenceInterval ( ) overlaps day of "Measurement Period"
        and DiabetesDB.clinicalStatus ~ "active"
  )

define "Has CKD Stage 5 or ESRD Diagnosis Overlaps Measurement Period":
  ( (["ConditionProblemsHealthConcerns": "Chronic Kidney Disease, Stage 5"] union ["ConditionEncounterDiagnosis": "Chronic Kidney Disease, Stage 5"])
    union (["ConditionProblemsHealthConcerns": "End Stage Renal Disease"] union ["ConditionEncounterDiagnosis": "End Stage Renal Disease"]) ) CKDOrESRD
    where CKDOrESRD.prevalenceInterval ( ) overlaps day of "Measurement Period"
      and CKDOrESRD.clinicalStatus ~ "active"

define "SDE Ethnicity":
  SDE."SDE Ethnicity"

define "SDE Payer":
  SDE."SDE Payer"

define "SDE Race":
  SDE."SDE Race"

define "SDE Sex":
  SDE."SDE Sex"