library FootAssessmentAndFollowUp version '0.0.000'

using QICore version '6.0.0'

include FHIRHelpers version '4.4.000' called FHIRHelpers
include SupplementalDataElements version '5.1.000' called SDE
include QICoreCommon version '4.0.000' called QICoreCommon
include Hospice version '6.14.000' called Hospice
include Status version '1.10.000' called Status

codesystem "SNOMEDCT": 'http://snomed.info/sct'

valueset "Acquired Absence Bilateral Feet": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.278'
// TODO: valueset "Absence Bilateral Feet": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.381'
valueset "Acquired Absence of Left Foot": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.281'
valueset "Acquired Absence of Right Foot": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.284'
valueset "Amputation of Bilateral Feet": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.287'
// TODO: valueset "Bilateral Feet Amputation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.285'
valueset "Amputation of Left Foot": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.291'
valueset "Amputation of Right Foot": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.294'
valueset "Amputation of Unspecified Foot": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.295'
valueset "Callus of Foot": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.306'
valueset "Deformity of Foot": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.309'
valueset "Diabetes": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.103.12.1001'
valueset "Follow Up Within 12 Months": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.326'
valueset "Foot Care Education": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.383'
valueset "Foot Care Referral": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.313'
valueset "Foot Pressure Offloading Devices": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.322'
valueset "Foot Pressure Offloading Interventions": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.321'
valueset "Home Visits": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.388'
valueset "Initial Preventive and Annual Wellness Visits": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.379'
valueset "Ipswich Soft Touch Test Abnormal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.333'
valueset "Ipswich Soft Touch Test and Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.348'
valueset "Ipswich Soft Touch Test Normal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.341'
valueset "Lower Extremity Visual Exam": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.305'
valueset "Lower Extremity Visual Exam Normal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.346'
valueset "Monofilament Foot Test": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.296'
valueset "Monofilament Test Abnormal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.328'
valueset "Monofilament Test Normal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.338'
valueset "Office Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1001'
valueset "Pedal Pulse Palpation Foot Test": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.304'
valueset "Pedal Pulse Test Abnormal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.337'
valueset "Pedal Pulse Test Normal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.345'
valueset "Pinprick Sensation Test Abnormal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.329'
valueset "Pinprick Sensation Test and Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.347'
valueset "Pinprick Sensation Test Normal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.339'
valueset "Preventive Services Established": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1025'
valueset "Preventive Services Initial": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1023'
valueset "Temperature Discrimination Foot Test": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.299'
valueset "Temperature Discrimination Test Abnormal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.334'
valueset "Temperature Discrimination Test Normal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.342'
valueset "Therapeutic Footwear Interventions": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.323'
valueset "Therapeutic Footwear": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.324'
valueset "Ulcer of Foot": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.317'
valueset "Vibration Sensation Foot Test": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.297'
valueset "Vibration Test Abnormal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.330'
valueset "Vibration Test Normal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.340'

code "Right (qualifier value)": '24028007' from "SNOMEDCT" display 'Right (qualifier value)'
code "Left (qualifier value)": '7771000' from "SNOMEDCT" display 'Left (qualifier value)'
code "Right and left (qualifier value)": '51440002' from "SNOMEDCT" display 'Right and left (qualifier value)'

parameter "Measurement Period" Interval<DateTime>

context Patient

define "Initial Population":
    AgeInYearsAt(date from start of "Measurement Period") >= 18
        and "Has Diabetes Diagnosis"
        and exists "Qualifying Encounters"

define "Denominator":
    "Initial Population"

define "Qualifying Encounters":
  ([Encounter: "Home Visits"]
    union [Encounter: "Initial Preventive and Annual Wellness Visits"]
    union [Encounter: "Office Visit"]
    union [Encounter: "Preventive Services Established"]
    union [Encounter: "Preventive Services Initial"]) QualifyingEncounter
        where QualifyingEncounter.status in {'finished', 'arrived', 'triaged', 'in-progress', 'onleave'}
            and QualifyingEncounter.period during day of "Measurement Period"

define "Denominator Exclusions":
    "Has Bilateral Lower Extremity Amputation at the Foot or Above"
        or Hospice."Has Hospice Services"

define "Has Diabetes Diagnosis":
    exists (
        [ConditionProblemsHealthConcerns: "Diabetes"] DiabetesDiagnosis
            where DiabetesDiagnosis.prevalenceInterval() overlaps "Measurement Period"
    )

define "First Qualifying Encounter Period":
    First(
        "Qualifying Encounters" QualifyingEncounter
            sort by start of period descending
    ).period

define "Has Bilateral Lower Extremity Amputation at the Foot or Above":
    "Both Feet Absent"
        or ("Left Foot Absent" and "Right Foot Absent")

define "Both Feet Absent":
    exists ("Acquired Absence Bilateral Feet Conditions")
        or exists ("Amputation of Bilateral Feet Procedures")
        
define "Left Foot Absent":
    exists ("Acquired Absence Right Foot Conditions")
        or exists ("Amputation of Left Foot Procedures")

define "Right Foot Absent":
    exists ("Acquired Absence Left Foot Conditions")
        or exists ("Amputation of Right Foot Procedures")

define "Acquired Absence Bilateral Feet Conditions":
    [ConditionProblemsHealthConcerns: "Acquired Absence Bilateral Feet"] BilateralFootAbsence
        where BilateralFootAbsence.prevalenceInterval() starts before "First Qualifying Encounter Period"

define "Acquired Absence Left Foot Conditions":
    [ConditionProblemsHealthConcerns: "Acquired Absence of Left Foot"] LeftFootAbsence
        where LeftFootAbsence.prevalenceInterval() starts before "First Qualifying Encounter Period"

define "Acquired Absence Right Foot Conditions":
    [ConditionProblemsHealthConcerns: "Acquired Absence of Right Foot"] RightFootAbsence
        where RightFootAbsence.prevalenceInterval() starts before "First Qualifying Encounter Period"

define "Amputation of Bilateral Feet Procedures":
    (
        [Procedure: "Amputation of Bilateral Feet"]
    ) 
    union (
        [Procedure: "Amputation of Unspecified Foot"] UnspecifiedFootAmputation
            where exists (
                UnspecifiedFootAmputation.bodySite BodySite where BodySite ~ "Right and left (qualifier value)"
            )
    ) BilateralFootAmputation
        where BilateralFootAmputation.status ~ 'completed'
            and end of BilateralFootAmputation.performed.toInterval() before start of "First Qualifying Encounter Period"

define "Amputation of Left Foot Procedures":
    (
        [Procedure: "Amputation of Left Foot"] 
    ) 
    union (
        [Procedure: "Amputation of Unspecified Foot"] UnspecifiedFootAmputation
            where exists (
                UnspecifiedFootAmputation.bodySite BodySite where BodySite ~ "Left (qualifier value)"
            )
    ) LeftFootAmputation
        where LeftFootAmputation.status ~ 'completed'
            and end of LeftFootAmputation.performed.toInterval() before start of "First Qualifying Encounter Period"

define "Amputation of Right Foot Procedures":
    (
        [Procedure: "Amputation of Right Foot"]
    ) 
    union (
        [Procedure: "Amputation of Unspecified Foot"] UnspecifiedFootAmputation
            where exists (
                UnspecifiedFootAmputation.bodySite BodySite where BodySite ~ "Right (qualifier value)"
            )
    ) RightFootAmputation
        where RightFootAmputation.status ~ 'completed'
            and end of RightFootAmputation.performed.toInterval() before start of "First Qualifying Encounter Period"
                
define "Numerator":
    (
        "Has At Least Two Normal Neurological Exam Findings of Lower Extremity"
            and "Has a Normal Vascular Exam Finding of Lower Extremity"
            and "Has a Normal Visual Inspection of Lower Extremity"
            and "Received Foot Care Education"
    ) 
    or (
        "Has Abnormal Exam Finding of Lower Extremity"
            and "Has Follow-Up Plan of Care Within One Week of Eligible Encounter"
    )

define "Has At Least Two Normal Neurological Exam Findings of Lower Extremity":
    Count("Qualifying Normal Neurological Exam Findings") >= 2
        and exists (
            "Qualifying Normal Neurological Exam Findings" NeurologicalExamType1
                with "Qualifying Normal Neurological Exam Findings" NeurologicalExamType2
                such that NeurologicalExamType1.code !~ NeurologicalExamType2.code
        )

define "Qualifying Normal Neurological Exam Findings":
    ("Normal Monofilament Foot Test Finding"
        union "Normal Pinprick Sensation Foot Test Finding"
        union "Normal Vibration Sensation Foot Test Finding"
        union "Normal Ipswich Soft Touch Test Finding"
        union "Normal Temperature Discrimination Foot Test Finding"
    ) NormalNeurologicalExam
        where NormalNeurologicalExam.status in { 'final', 'amended', 'corrected' }
            and NormalNeurologicalExam.effective.toInterval() during day of "Measurement Period"

define "Normal Monofilament Foot Test Finding":
    [ObservationClinicalResult: "Monofilament Foot Test"] MonofilmanetFootTest
        where MonofilmanetFootTest.value is not null 
            and (MonofilmanetFootTest.value as Concept) in "Monofilament Test Normal Finding"
                    
define "Normal Pinprick Sensation Foot Test Finding":
    [ObservationClinicalResult: "Pinprick Sensation Test and Finding"] PinprickTest
        where PinprickTest.value is not null 
            and (PinprickTest.value as Concept) in "Pinprick Sensation Test Normal Finding"

define "Normal Vibration Sensation Foot Test Finding":
    [ObservationClinicalResult: "Vibration Sensation Foot Test"] VibrationTest
        where VibrationTest.value is not null
            and (VibrationTest.value as Concept) in "Vibration Test Normal Finding"

define "Normal Ipswich Soft Touch Test Finding":
    [ObservationClinicalResult: "Ipswich Soft Touch Test and Finding"] IpswichTest 
        where IpswichTest.value is not null
            and (IpswichTest.value as Concept) in "Ipswich Soft Touch Test Normal Finding"
                
define "Normal Temperature Discrimination Foot Test Finding":
    [ObservationClinicalResult: "Temperature Discrimination Foot Test"] TemperatureTest
        where TemperatureTest.value is not null
            and (TemperatureTest.value as Concept) in "Temperature Discrimination Test Normal Finding"

define "Has a Normal Vascular Exam Finding of Lower Extremity":
    exists (
        [ObservationClinicalResult: "Pedal Pulse Palpation Foot Test"] VascularExam
            where VascularExam.value is not null
                and (VascularExam.value as Concept) in "Pedal Pulse Test Normal Finding"
                and VascularExam.status in { 'final', 'amended', 'corrected' }
                and VascularExam.effective.toInterval() during day of "Measurement Period"
    )

define "Has a Normal Visual Inspection of Lower Extremity":
    exists (
        [ObservationClinicalResult: "Lower Extremity Visual Exam"] VisualExam
            where VisualExam.value is not null
                and (VisualExam.value as Concept) in "Lower Extremity Visual Exam Normal Finding"
                and VisualExam.status in { 'final', 'amended', 'corrected' }
                and VisualExam.effective.toInterval() during day of "Measurement Period" 
    )
    
define "Received Foot Care Education":
    exists (
        [Procedure: "Foot Care Education"] FootCareEducation
            where FootCareEducation.status ~ 'completed'
                and FootCareEducation.performed.toInterval() during day of "Measurement Period"
    )

define "Has Abnormal Exam Finding of Lower Extremity":
    exists (
        (
            "Abnormal Monofilament Foot Test Finding"
                union "Abnormal Pinprick Sensation Foot Test Finding"
                union "Abnormal Vibration Sensation Foot Test Finding"
                union "Abnormal Ipswich Soft Touch Test Finding"
                union "Abnormal Temperature Discrimination Foot Test Finding"
                union "Abnormal Vascular Exam Finding of Lower Extremity"
        ) AbnormalObservation
                where AbnormalObservation.status in { 'final', 'amended', 'corrected' }
                    and AbnormalObservation.effective.toInterval() during day of "Measurement Period"
    )
    or exists (
        (
            [ConditionEncounterDiagnosis: "Callus of Foot"]
                union [ConditionEncounterDiagnosis: "Deformity of Foot"]
                union [ConditionEncounterDiagnosis: "Ulcer of Foot"]
        ) AbnormalCondition
            where AbnormalCondition.isActive()
                and AbnormalCondition.onset.toInterval() during day of "Measurement Period"   
    )

define "Abnormal Monofilament Foot Test Finding":
    [ObservationClinicalResult: "Monofilament Foot Test"] MonofilmanetFootTest
        where MonofilmanetFootTest.value is not null
            and (MonofilmanetFootTest.value as Concept) in "Monofilament Test Abnormal Finding"

define "Abnormal Pinprick Sensation Foot Test Finding":
    [ObservationClinicalResult: "Pinprick Sensation Test and Finding"] PinprickTest
        where PinprickTest.value is not null 
            and (PinprickTest.value as Concept) in "Pinprick Sensation Test Abnormal Finding"

define "Abnormal Vibration Sensation Foot Test Finding":
    [ObservationClinicalResult: "Vibration Sensation Foot Test"] VibrationTest
        where VibrationTest.value is not null
            and (VibrationTest.value as Concept) in "Vibration Test Abnormal Finding"

define "Abnormal Ipswich Soft Touch Test Finding":
    [ObservationClinicalResult: "Ipswich Soft Touch Test and Finding"] IpswichTest 
        where IpswichTest.value is not null
            and (IpswichTest.value as Concept) in "Ipswich Soft Touch Test Abnormal Finding"

define "Abnormal Temperature Discrimination Foot Test Finding":
    [ObservationClinicalResult: "Temperature Discrimination Foot Test"] TemperatureTest
        where TemperatureTest.value is not null
            and (TemperatureTest.value as Concept) in "Temperature Discrimination Test Abnormal Finding"

define "Abnormal Vascular Exam Finding of Lower Extremity":
    [ObservationClinicalResult: "Pedal Pulse Palpation Foot Test"] VascularExam
        where VascularExam.value is not null
            and (VascularExam.value as Concept) in "Pedal Pulse Test Abnormal Finding"

define "Has Follow-Up Plan of Care Within One Week of Eligible Encounter":
    exists (
        "Qualifying Encounters" QualifyingEncounter 
            let "Seven-Day Period Following Qualifying Encounter": Interval[start of QualifyingEncounter.period, end of QualifyingEncounter.period + 7 days]
            where exists ( 
                (
                    (
                        [Procedure: "Foot Pressure Offloading Interventions"] 
                            union [Procedure: "Therapeutic Footwear Interventions"]
                    ) FollowUpProcedure
                        where FollowUpProcedure.status ~ 'completed'
                            and FollowUpProcedure.performed.toInterval() during day of "Seven-Day Period Following Qualifying Encounter"
                )
                union (
                    (
                        [ServiceRequest: "Foot Care Referral"]
                            union [ServiceRequest: "Follow Up Within 12 Months"]
                    ) FollowUpServiceRequest
                        where FollowUpServiceRequest.status in { 'active', 'completed' }
                            and FollowUpServiceRequest.intent = 'order'
                            and FollowUpServiceRequest.authoredOn.toInterval() during day of "Seven-Day Period Following Qualifying Encounter"
                )
                union (
                    (
                        [DeviceRequest: "Foot Pressure Offloading Devices"]
                            union [DeviceRequest: "Therapeutic Footwear"]
                    ) FollowUpDeviceRequest
                        where FollowUpDeviceRequest.status in { 'active', 'completed' }
                            and FollowUpDeviceRequest.intent = 'order'
                            and FollowUpDeviceRequest.authoredOn.toInterval() during day of "Seven-Day Period Following Qualifying Encounter"
                )
            )
    )

define "SDE Ethnicity":
  SDE."SDE Ethnicity"

define "SDE Payer":
  SDE."SDE Payer"

define "SDE Race":
  SDE."SDE Race"

define "SDE Sex":
  SDE."SDE Sex"