library CMS347FHIRStatinPreventionTreatmentCVD version '0.3.000'

using QICore version '6.0.0'

include FHIRHelpers version '4.4.000' called FHIRHelpers
include Hospice version '6.15.000' called Hospice
include PalliativeCare version '1.15.000' called PalliativeCare
include QICoreCommon version '4.0.000' called QICoreCommon
include SupplementalDataElements version '5.1.000' called SDE
include CumulativeMedicationDuration version '6.0.000' called CMD

codesystem "ICD10CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'

valueset "Annual Wellness Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1240'
valueset "Atherosclerosis and Peripheral Arterial Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1047.21'
valueset "Breastfeeding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1047.73'
valueset "CABG Surgeries": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.5.694'
valueset "CABG or PCI Procedure": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1138.566'
valueset "Carotid Intervention": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.204'
valueset "Cerebrovascular Disease Stroke or TIA": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1047.44'
valueset "Diabetes": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.103.12.1001'
valueset "End Stage Renal Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.353'
valueset "Familial Hypercholesterolemia": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1047.100'
valueset "Hepatitis A": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.110.12.1024'
valueset "Hepatitis B": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.67.1.101.1.269'
valueset "High Intensity Statin Therapy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1572'
valueset "Ischemic Heart Disease or Other Related Diagnoses": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1047.46'
valueset "LDL Cholesterol": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1573'
valueset "Liver Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1047.42'
valueset "Low Intensity Statin Therapy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1574'
valueset "Medical Reason": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1007'
valueset "Moderate Intensity Statin Therapy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1575'
valueset "Myocardial Infarction": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1108.101'
valueset "Office Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1001'
valueset "Outpatient Consultation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1008'
valueset "Outpatient Encounters for Preventive Care": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1576'
valueset "PCI": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1045.67'
valueset "Preventive Care Services Established Office Visit, 18 and Up": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1025'
valueset "Preventive Care Services Individual Counseling": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1026'
valueset "Preventive Care Services Initial Office Visit, 18 and Up": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1023'
valueset "Preventive Care Services Other": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.11.1150'
valueset "Rhabdomyolysis": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1047.102'
valueset "Stable and Unstable Angina": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1047.47'
valueset "Statin Allergen": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.42'
valueset "Statin Associated Muscle Symptoms": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1108.85'
valueset "Telemedicine Services": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.276'

code "Cardiovascular disease 10Y risk [Likelihood]": '99055-6' from "LOINC" display 'Cardiovascular disease 10Y risk [Likelihood]'
code "Cardiovascular disease 10Y risk [Likelihood] ACC-AHA Pooled Cohort by Goff 2013": '79423-0' from "LOINC" display 'Cardiovascular disease 10Y risk [Likelihood] ACC-AHA Pooled Cohort by Goff 2013'
code "Subsequent non-ST elevation (NSTEMI) myocardial infarction": 'I22.2' from "ICD10CM" display 'Subsequent non-ST elevation (NSTEMI) myocardial infarction'

parameter "Measurement Period" Interval<DateTime>

context Patient

define "Initial Population 1":
  exists "ASCVD Diagnosis or Procedure before End of Measurement Period"
    and exists "Qualifying Encounter during day of Measurement Period"

define "Initial Population 2":
  "Patients Aged 20 to 75 with LDL Cholesterol Result Greater than or Equal to 190 or Hypercholesterolemia without ASCVD"
    and exists "Qualifying Encounter during day of Measurement Period"

define "Initial Population 3":
  "Patients Aged 40 to 75 Years with Diabetes without ASCVD or LDL Greater than 190 or Hypercholesterolemia"
    and exists "Qualifying Encounter during day of Measurement Period"

define "Initial Population 4":
  "Patients Age 40 to 75 Years and have a 10 Year CVD Risk of High without ASCVD and High LDL and Diabetes"
    and exists "Qualifying Encounter during day of Measurement Period"

define "Denominator 1":
  "Initial Population 1"

define "Denominator 2":
  "Initial Population 2"

define "Denominator 3":
  "Initial Population 3"

define "Denominator 4":
  "Initial Population 4"

define "Denominator Exclusions":
  exists ( ( [ConditionProblemsHealthConcerns: "Breastfeeding"]
      union [ConditionProblemsHealthConcerns: "Rhabdomyolysis"] ) ExclusionDiagnosis
      where ExclusionDiagnosis.prevalenceInterval ( ) overlaps day of "Measurement Period"
        and ExclusionDiagnosis.verificationStatusIsNotInvalid ( )
  )

define "Denominator Exceptions":
  "Has Allergy to Statin"
    or Hospice."Has Hospice Services"
    or PalliativeCare."Has Palliative Care in the Measurement Period"
    or "Has Hepatitis or Liver Disease Diagnosis"
    or "Has Statin Associated Muscle Symptoms"
    or "Has ESRD Diagnosis"
    or "Has Adverse Reaction to Statin"
    or "Has Medical Reason for Not Ordering Statin Therapy"

define "Numerator":
  exists "Statin Therapy Ordered during Measurement Period"
    or exists "Medication Active during the Measurement Period"

define "ASCVD Diagnosis or Procedure before End of Measurement Period":
  ( ( [ConditionProblemsHealthConcerns: "Myocardial Infarction"]
      union [ConditionProblemsHealthConcerns: "Subsequent non-ST elevation (NSTEMI) myocardial infarction"]
      union [ConditionProblemsHealthConcerns: "Cerebrovascular Disease Stroke or TIA"]
      union [ConditionProblemsHealthConcerns: "Atherosclerosis and Peripheral Arterial Disease"]
      union [ConditionProblemsHealthConcerns: "Ischemic Heart Disease or Other Related Diagnoses"]
      union [ConditionProblemsHealthConcerns: "Stable and Unstable Angina"] ) ASCVDDiagnosis
      where ASCVDDiagnosis.prevalenceInterval ( ) starts on or before day of end of "Measurement Period"
        and ASCVDDiagnosis.verificationStatusIsNotInvalid ( )
  )
    union ( ( [Procedure: "PCI"]
        union [Procedure: "CABG Surgeries"]
        union [Procedure: "Carotid Intervention"]
        union [Procedure: "CABG or PCI Procedure"] ) ASCVDProcedure
        where ASCVDProcedure.performed.toInterval ( ) starts on or before day of end of "Measurement Period"
          and ASCVDProcedure.status = 'completed'
    )

define "Has Adverse Reaction to Statin":
  exists ( [AdverseEvent: "Statin Allergen"] StatinReaction
      where Coalesce(StatinReaction.date, StatinReaction.recordedDate) during day of "Measurement Period"
  )

define "Has Allergy to Statin":
  exists ( [AllergyIntolerance: "Statin Allergen"] StatinAllergy
      where StatinAllergy.onset.toInterval ( ) overlaps day of "Measurement Period"
        and StatinAllergy.clinicalStatus ~ QICoreCommon."allergy-active"
  )

define "Has Diabetes Diagnosis":
  exists ( [ConditionProblemsHealthConcerns: "Diabetes"] DiabetesDiagnosis
      where DiabetesDiagnosis.prevalenceInterval ( ) overlaps day of "Measurement Period"
        and DiabetesDiagnosis.verificationStatusIsNotInvalid ( )
  )

define "Has ESRD Diagnosis":
  exists ( [ConditionProblemsHealthConcerns: "End Stage Renal Disease"] ESRD
      where ESRD.prevalenceInterval ( ) overlaps day of "Measurement Period"
        and ESRD.verificationStatusIsNotInvalid ( )
  )

define "Has Hepatitis or Liver Disease Diagnosis":
  exists ( ( [ConditionProblemsHealthConcerns: "Hepatitis A"]
      union [ConditionProblemsHealthConcerns: "Hepatitis B"]
      union [ConditionProblemsHealthConcerns: "Liver Disease"] ) HepatitisLiverDisease
      where HepatitisLiverDisease.prevalenceInterval ( ) overlaps day of "Measurement Period"
        and HepatitisLiverDisease.verificationStatusIsNotInvalid ( )
  )

define "Has Medical Reason for Not Ordering Statin Therapy":
  exists ( ( [MedicationNotRequested: "Low Intensity Statin Therapy"]
      union [MedicationNotRequested: "Moderate Intensity Statin Therapy"]
      union [MedicationNotRequested: "High Intensity Statin Therapy"] ) NoStatinTherapyOrdered
      with "Qualifying Encounter during day of Measurement Period" QualifyingEncounter
        such that NoStatinTherapyOrdered.authoredOn during day of QualifyingEncounter.period
          and NoStatinTherapyOrdered.status in { 'active', 'completed' }
          and NoStatinTherapyOrdered.reasonCode in "Medical Reason"
  )

define "Has Statin Associated Muscle Symptoms":
  exists ( [ConditionProblemsHealthConcerns: "Statin Associated Muscle Symptoms"] StatinMuscleSymptom
      where StatinMuscleSymptom.prevalenceInterval ( ) overlaps day of "Measurement Period"
        and StatinMuscleSymptom.verificationStatusIsNotInvalid ( )
  )

define "Hypercholesterolemia Diagnosis":
  ( [ConditionProblemsHealthConcerns: "Familial Hypercholesterolemia"] Hypercholesterolemia
      where Hypercholesterolemia.prevalenceInterval ( ) starts on or before day of end of "Measurement Period"
        and Hypercholesterolemia.verificationStatusIsNotInvalid ( )
  )

define "LDL Result Greater Than or Equal To 190":
  [LaboratoryResultObservation: "LDL Cholesterol"] LDL190
    where LDL190.value as Quantity >= 190 'mg/dL'
      and LDL190.effective.toInterval ( ) starts on or before day of end of "Measurement Period"
      and LDL190.status in { 'final', 'amended', 'corrected', 'appended' }

define "Medication Active during the Measurement Period":
  ( [MedicationRequest: "Low Intensity Statin Therapy"]
    union [MedicationRequest: "Moderate Intensity Statin Therapy"]
    union [MedicationRequest: "High Intensity Statin Therapy"] ) ActiveStatin
    where ActiveStatin.medicationRequestPeriod ( ) overlaps day of "Measurement Period"
      and ActiveStatin.status in { 'active', 'completed' }

define "Patients Aged 20 to 75 with LDL Cholesterol Result Greater than or Equal to 190 or Hypercholesterolemia without ASCVD":
  "Patients Aged 20 to 75 at Start of Measurement Period"
    and exists ( "LDL Result Greater Than or Equal To 190"
        union "Hypercholesterolemia Diagnosis"
    )
    and not exists ( "ASCVD Diagnosis or Procedure before End of Measurement Period" )

define "Patients Aged 20 to 75 at Start of Measurement Period":
  AgeInYearsAt(date from start of "Measurement Period") in Interval[20, 75]

define "Patients Aged 40 to 75 Years with Diabetes without ASCVD or LDL Greater than 190 or Hypercholesterolemia":
  AgeInYearsAt(date from start of "Measurement Period") in Interval[40, 75]
    and "Has Diabetes Diagnosis"
    and ( not exists "ASCVD Diagnosis or Procedure before End of Measurement Period"
        and not exists "LDL Result Greater Than or Equal To 190"
        and not exists "Hypercholesterolemia Diagnosis"
    )

define "Patients Age 40 to 75 Years and have a 10 Year CVD Risk of High without ASCVD and High LDL and Diabetes":
  AgeInYearsAt(date from start of "Measurement Period") in Interval[40, 75]
    and "Ten Year CVD Risk is High"
    and not ( exists "ASCVD Diagnosis or Procedure before End of Measurement Period"
        or exists "Hypercholesterolemia Diagnosis"
        or exists "LDL Result Greater Than or Equal To 190"
        or "Has Diabetes Diagnosis"
    )

define "Qualifying Encounter during day of Measurement Period":
  ( [Encounter: "Annual Wellness Visit"]
    union [Encounter: "Office Visit"]
    union [Encounter: "Outpatient Consultation"]
    union [Encounter: "Outpatient Encounters for Preventive Care"]
    union [Encounter: "Preventive Care Services Established Office Visit, 18 and Up"]
    union [Encounter: "Preventive Care Services Individual Counseling"]
    union [Encounter: "Preventive Care Services Initial Office Visit, 18 and Up"]
    union [Encounter: "Preventive Care Services Other"]
    union [Encounter: "Telemedicine Services"] ) QualifyingEncounter
    where QualifyingEncounter.period during day of "Measurement Period"
      and QualifyingEncounter.status = 'finished'

define "Statin Therapy Ordered during Measurement Period":
  ( [MedicationRequest: "Low Intensity Statin Therapy"]
    union [MedicationRequest: "Moderate Intensity Statin Therapy"]
    union [MedicationRequest: "High Intensity Statin Therapy"] ) StatinRequest
    where StatinRequest.authoredOn during day of "Measurement Period"
      and StatinRequest.status in { 'active', 'completed' }
      and StatinRequest.intent in { 'order', 'original-order', 'reflex-order', 'filter-order', 'instance-order' }

define "Ten Year CVD Risk is High":
  exists ( ( [ObservationScreeningAssessment: "Cardiovascular disease 10Y risk [Likelihood]"]
      union [ObservationScreeningAssessment: "Cardiovascular disease 10Y risk [Likelihood] ACC-AHA Pooled Cohort by Goff 2013"] ) AtRiskCVD
      where AtRiskCVD.value as Quantity >= 20 '%'
        and AtRiskCVD.effective.toInterval ( ) during day of "Measurement Period"
        and AtRiskCVD.status in { 'final', 'amended', 'corrected' }
  )

define fluent function verificationStatusIsNotInvalid(condition Choice<"ConditionEncounterDiagnosis", "ConditionProblemsHealthConcerns">):
  condition.verificationStatus is null
    or not ( condition.verificationStatus ~ QICoreCommon."unconfirmed"
        or condition.verificationStatus ~ QICoreCommon."refuted"
        or condition.verificationStatus ~ QICoreCommon."entered-in-error"
    )

define "SDE Ethnicity":
  SDE."SDE Ethnicity"

define "SDE Payer":
  SDE."SDE Payer"

define "SDE Race":
  SDE."SDE Race"

define "SDE Sex":
  SDE."SDE Sex"