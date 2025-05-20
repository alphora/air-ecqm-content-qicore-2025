library FootAssessmentAndFollowUp version '0.0.000'

using QICore version '6.0.0'

include FHIRHelpers version '4.4.000' called FHIRHelpers
include SupplementalDataElements version '5.1.000' called SDE
include QICoreCommon version '4.0.000' called QICoreCommon
include Hospice version '6.15.000' called Hospice
include Status version '1.13.000' called Status

codesystem "ActCode": 'http://terminology.hl7.org/CodeSystem/v3-ActCode'
codesystem "SNOMEDCT": 'http://snomed.info/sct'
 
// Denominator
valueset "Diabetes": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.103.12.1001'

// Denominator - Eligible Encounters
valueset "Initial Preventive and Annual Wellness Visits": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.379'
valueset "Office Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1001'
valueset "Preventive Services Established": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1025'
valueset "Preventive Services Initial": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1023'
valueset "Home Visits": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.388'

// Denominator Exclusions - Foot Amputations
valueset "Absence Bilateral Feet": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.381'
valueset "Absence Left Foot": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.281'
valueset "Absence Right Foot": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.284'
valueset "Bilateral Feet Amputation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.285'
valueset "Left Foot Amputation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.291'
valueset "Right Foot Amputation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.294'
valueset "Unspecified Foot Amputation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.295'

// Numerator - Lower Extremity Neurological Exam (>= 2 of the following tests)
valueset "Monofilament Foot Test": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.296'
valueset "Monofilament Test Abnormal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.328'
valueset "Monofilament Test Normal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.338'
valueset "Pinprick Sensation Test Abnormal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.329'
valueset "Pinprick Sensation Test and Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.347'
valueset "Pinprick Sensation Test Normal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.339'
valueset "Vibration Sensation Foot Test": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.297'
valueset "Vibration Test Abnormal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.330'
valueset "Vibration Test Normal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.340'
valueset "Ipswich Soft Touch Test Abnormal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.333'
valueset "Ipswich Soft Touch Test and Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.348'
valueset "Ipswich Soft Touch Test Normal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.341'
valueset "Temperature Discrimination Foot Test": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.299'
valueset "Temperature Discrimination Test Abnormal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.334'
valueset "Temperature Discrimination Test Normal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.342'

// Numerator - Lower Extremity Vascular Exam
valueset "Pedal Pulse Palpation Foot Test": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.304'
valueset "Pedal Pulse Test Abnormal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.337'
valueset "Pedal Pulse Test Normal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.345'

// Numerator - Lower Extremity Visual Exam
valueset "Lower Extremity Visual Exam": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.305'
valueset "Lower Extremity Visual Exam Normal Finding": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.346'
valueset "Callus of Foot": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.306'
valueset "Deformity of Foot": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.309'
valueset "Ulcer of Foot": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.317'
valueset "Fissure or Blister of Foot": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.393'

// Numerator - Foot Care Follow-ups
valueset "Foot Care Education": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.383'
valueset "Foot Care Referral": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.313'
valueset "Foot Pressure Offloading Interventions": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.321'
valueset "Foot Pressure Offloading Devices": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.322'
valueset "Therapeutic Footwear Interventions": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.323'
valueset "Therapeutic Footwear": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.324'
valueset "Follow Up Within 12 Months": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.326'
valueset "Under Care of Foot Care Provider": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.394'
valueset "Podiatric Occupations": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.403'

code "virtual": 'VR' from "ActCode" display 'virtual'
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
  (
    [Encounter: "Initial Preventive and Annual Wellness Visits"] 
        union [Encounter: "Office Visit"]
        union [Encounter: "Preventive Services Established"]
        union [Encounter: "Preventive Services Initial"]
        union [Encounter: "Home Visits"]
  ) QualifyingEncounter
        where QualifyingEncounter.period during day of "Measurement Period"
            and QualifyingEncounter.status = 'finished'
            and QualifyingEncounter.class !~ "virtual"

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
    exists ("Acquired Absence Left Foot Conditions")
        or exists ("Amputation of Left Foot Procedures")

define "Right Foot Absent":
    exists ("Acquired Absence Right Foot Conditions")
        or exists ("Amputation of Right Foot Procedures")

define "Acquired Absence Bilateral Feet Conditions":
    [ConditionProblemsHealthConcerns: "Absence Bilateral Feet"] BilateralFootAbsence
        where BilateralFootAbsence.prevalenceInterval() starts before "First Qualifying Encounter Period"

define "Acquired Absence Left Foot Conditions":
    [ConditionProblemsHealthConcerns: "Absence Left Foot"] LeftFootAbsence
        where LeftFootAbsence.prevalenceInterval() starts before "First Qualifying Encounter Period"

define "Acquired Absence Right Foot Conditions":
    [ConditionProblemsHealthConcerns: "Absence Right Foot"] RightFootAbsence
        where RightFootAbsence.prevalenceInterval() starts before "First Qualifying Encounter Period"

define "Amputation of Bilateral Feet Procedures":
    ((
        [Procedure: "Bilateral Feet Amputation"]
    ) 
    union (
        [Procedure: "Unspecified Foot Amputation"] UnspecifiedFootAmputation
            where exists (
                UnspecifiedFootAmputation.bodySite BodySite where BodySite ~ "Right and left (qualifier value)"
            )
    )) BilateralFootAmputation
        where BilateralFootAmputation.status ~ 'completed'
            and end of BilateralFootAmputation.performed.toInterval() before start of "First Qualifying Encounter Period"

define "Amputation of Left Foot Procedures":
    ((
        [Procedure: "Left Foot Amputation"] 
    ) 
    union (
        [Procedure: "Unspecified Foot Amputation"] UnspecifiedFootAmputation
            where exists (
                UnspecifiedFootAmputation.bodySite BodySite where BodySite ~ "Left (qualifier value)"
            )
    )) LeftFootAmputation
        where LeftFootAmputation.status ~ 'completed'
            and end of LeftFootAmputation.performed.toInterval() before start of "First Qualifying Encounter Period"

define "Amputation of Right Foot Procedures":
    ((
        [Procedure: "Right Foot Amputation"]
    ) 
    union (
        [Procedure: "Unspecified Foot Amputation"] UnspecifiedFootAmputation
            where exists (
                UnspecifiedFootAmputation.bodySite BodySite where BodySite ~ "Right (qualifier value)"
            )
    )) RightFootAmputation
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
        "Has At Least Two Neurological Exam Findings of Lower Extremity"
            and exists("Vascular Exam Finding of Lower Extremity")
            and exists("Visual Inspection of Lower Extremity")
            and "Received Foot Care Education"
            and "Has Abnormal Exam Finding of Lower Extremity"
            and "Has Follow-Up Plan of Care Within One Week of Eligible Encounter with Abnormal Finding"
    )

define "Has At Least Two Neurological Exam Findings of Lower Extremity":
    Count("Qualifying Neurological Exam Findings") >= 2

define "Has At Least Two Normal Neurological Exam Findings of Lower Extremity":
    Count("Qualifying Normal Neurological Exam Findings") >= 2
        and exists (
            "Qualifying Normal Neurological Exam Findings" NeurologicalExamType1
                with "Qualifying Normal Neurological Exam Findings" NeurologicalExamType2
                such that NeurologicalExamType1.code !~ NeurologicalExamType2.code
        )

define "Qualifying Neurological Exam Findings":
    ("Monofilament Foot Test Finding"
        union "Pinprick Sensation Foot Test Finding"
        union "Vibration Sensation Foot Test Finding"
        union "Ipswich Soft Touch Test Finding"
        union "Temperature Discrimination Foot Test Finding"
    ) NormalNeurologicalExam
        where NormalNeurologicalExam.status in { 'final', 'amended', 'corrected' }
            and NormalNeurologicalExam.effective.toInterval() during day of "Measurement Period"

define "Qualifying Normal Neurological Exam Findings":
    ("Normal Monofilament Foot Test Finding"
        union "Normal Pinprick Sensation Foot Test Finding"
        union "Normal Vibration Sensation Foot Test Finding"
        union "Normal Ipswich Soft Touch Test Finding"
        union "Normal Temperature Discrimination Foot Test Finding"
    ) NormalNeurologicalExam
        where NormalNeurologicalExam.status in { 'final', 'amended', 'corrected' }
            and NormalNeurologicalExam.effective.toInterval() during day of "Measurement Period"

define "Monofilament Foot Test Finding":
    [ObservationClinicalResult: "Monofilament Foot Test"] MonofilmanetFootTest
        where MonofilmanetFootTest.value is not null 
                    
define "Pinprick Sensation Foot Test Finding":
    [ObservationClinicalResult: "Pinprick Sensation Test and Finding"] PinprickTest
        where PinprickTest.value is not null 

define "Vibration Sensation Foot Test Finding":
    [ObservationClinicalResult: "Vibration Sensation Foot Test"] VibrationTest
        where VibrationTest.value is not null

define "Ipswich Soft Touch Test Finding":
    [ObservationClinicalResult: "Ipswich Soft Touch Test and Finding"] IpswichTest 
        where IpswichTest.value is not null
                
define "Temperature Discrimination Foot Test Finding":
    [ObservationClinicalResult: "Temperature Discrimination Foot Test"] TemperatureTest
        where TemperatureTest.value is not null

define "Normal Monofilament Foot Test Finding":
    "Monofilament Foot Test Finding" MonofilmanetFootTest
        where (MonofilmanetFootTest.value as System.Concept) in "Monofilament Test Normal Finding"
                    
define "Normal Pinprick Sensation Foot Test Finding":
    "Pinprick Sensation Foot Test Finding" PinprickTest
        where (PinprickTest.value as System.Concept) in "Pinprick Sensation Test Normal Finding"

define "Normal Vibration Sensation Foot Test Finding":
    "Vibration Sensation Foot Test Finding" VibrationTest
        where (VibrationTest.value as System.Concept) in "Vibration Test Normal Finding"

define "Normal Ipswich Soft Touch Test Finding":
    "Ipswich Soft Touch Test Finding" IpswichTest 
        where (IpswichTest.value as System.Concept) in "Ipswich Soft Touch Test Normal Finding"
                
define "Normal Temperature Discrimination Foot Test Finding":
    "Temperature Discrimination Foot Test Finding" TemperatureTest
        where (TemperatureTest.value as System.Concept) in "Temperature Discrimination Test Normal Finding"

define "Vascular Exam Finding of Lower Extremity":
    [ObservationClinicalResult: "Pedal Pulse Palpation Foot Test"] VascularExam
        where VascularExam.value is not null
            and VascularExam.status in { 'final', 'amended', 'corrected' }
            and VascularExam.effective.toInterval() during day of "Measurement Period"

define "Has a Normal Vascular Exam Finding of Lower Extremity":
    exists (
        "Vascular Exam Finding of Lower Extremity" VascularExam
            where (VascularExam.value as System.Concept) in "Pedal Pulse Test Normal Finding"
    )

define "Visual Inspection of Lower Extremity":
    [ObservationClinicalResult: "Lower Extremity Visual Exam"] VisualExam
        where VisualExam.value is not null
            and VisualExam.status in { 'final', 'amended', 'corrected' }
            and VisualExam.effective.toInterval() during day of "Measurement Period" 

define "Has a Normal Visual Inspection of Lower Extremity":
    exists (
        "Visual Inspection of Lower Extremity" VisualExam
            where (VisualExam.value as System.Concept) in "Lower Extremity Visual Exam Normal Finding"
    )
    
define "Received Foot Care Education":
    exists (
        [Procedure: "Foot Care Education"] FootCareEducation
            where FootCareEducation.status ~ 'completed'
                and FootCareEducation.performed.toInterval() during day of "Measurement Period"
    )

define "Has Abnormal Exam Finding of Lower Extremity":
    exists (
        "Abnormal Exam Finding of Lower Extremity"
    )
    or exists (
        "Abnormal Condition of Lower Extremity"
    )

define "Abnormal Exam Finding of Lower Extremity":
    (
        "Abnormal Monofilament Foot Test Finding"
            union "Abnormal Pinprick Sensation Foot Test Finding"
            union "Abnormal Vibration Sensation Foot Test Finding"
            union "Abnormal Ipswich Soft Touch Test Finding"
            union "Abnormal Temperature Discrimination Foot Test Finding"
            union "Abnormal Vascular Exam Finding of Lower Extremity"
            union "Abnormal Visual Exam Finding of Lower Extremity"
    ) AbnormalObservation
        where AbnormalObservation.status in { 'final', 'amended', 'corrected' }
            and AbnormalObservation.effective.toInterval() during day of "Measurement Period"

define "Abnormal Condition of Lower Extremity":
    (
        [ConditionEncounterDiagnosis: "Callus of Foot"]
            union [ConditionEncounterDiagnosis: "Deformity of Foot"]
            union [ConditionEncounterDiagnosis: "Ulcer of Foot"]
            union [ConditionEncounterDiagnosis: "Fissure or Blister of Foot"]
    ) AbnormalCondition
        where AbnormalCondition.isActive()
            and AbnormalCondition.prevalenceInterval() overlaps day of "Measurement Period"   

define "Abnormal Monofilament Foot Test Finding":
    "Monofilament Foot Test Finding" MonofilmanetFootTest
        where (MonofilmanetFootTest.value as System.Concept) in "Monofilament Test Abnormal Finding"

define "Abnormal Pinprick Sensation Foot Test Finding":
    "Pinprick Sensation Foot Test Finding" PinprickTest
        where (PinprickTest.value as System.Concept) in "Pinprick Sensation Test Abnormal Finding"

define "Abnormal Vibration Sensation Foot Test Finding":
    "Vibration Sensation Foot Test Finding" VibrationTest
        where (VibrationTest.value as System.Concept) in "Vibration Test Abnormal Finding"

define "Abnormal Ipswich Soft Touch Test Finding":
    "Ipswich Soft Touch Test Finding" IpswichTest 
        where (IpswichTest.value as System.Concept) in "Ipswich Soft Touch Test Abnormal Finding"

define "Abnormal Temperature Discrimination Foot Test Finding":
    "Temperature Discrimination Foot Test Finding" TemperatureTest
        where (TemperatureTest.value as System.Concept) in "Temperature Discrimination Test Abnormal Finding"

define "Abnormal Vascular Exam Finding of Lower Extremity":
    "Vascular Exam Finding of Lower Extremity" VascularExam
        where (VascularExam.value as System.Concept) in "Pedal Pulse Test Abnormal Finding"

define "Abnormal Visual Exam Finding of Lower Extremity":
    "Visual Inspection of Lower Extremity" VisualExam
        where VisualExam.value is not null
            and (
                (VisualExam.value as System.Concept) in "Callus of Foot"
                    or (VisualExam.value as System.Concept) in "Deformity of Foot"
                    or (VisualExam.value as System.Concept) in "Ulcer of Foot"
                    or (VisualExam.value as System.Concept) in "Fissure or Blister of Foot"
            )    

define "Qualifying Encounters with Abnormal Exam Finding of Lower Extremity":
    (
        "Qualifying Encounters" QualifyingEncounter
          with "Abnormal Exam Finding of Lower Extremity" LowerExtremityAbnormalClinicalResult
            such that LowerExtremityAbnormalClinicalResult.effective.toInterval() overlaps QualifyingEncounter.period
    ) 
    union
    (
        "Qualifying Encounters" QualifyingEncounter
          with "Abnormal Condition of Lower Extremity" LowerExtremityAbnormalCondition
            such that LowerExtremityAbnormalCondition.prevalenceInterval() overlaps QualifyingEncounter.period
    )

define "Care Teams with Podiatrist Participant Role":
  [CareTeam] CT
    where CT.participant.role in "Podiatric Occupations"

define "Care Teams with Podiatrist PractitionerRole":
  [CareTeam] CT
    with ([PractitionerRole: "Podiatric Occupations"]) PodiatristPractitionerRole
      such that CT.participant.member.references(PodiatristPractitionerRole)

define "Has Follow-Up Plan of Care Within One Week of Eligible Encounter with Abnormal Finding":
    exists (
        "Qualifying Encounters with Abnormal Exam Finding of Lower Extremity" QualifyingEncounter 
            let "Seven-Day Period Following Qualifying Encounter": Interval[start of QualifyingEncounter.period, end of QualifyingEncounter.period + 7 days]
            where exists ( 
                (
                    (
                        [Procedure: "Foot Pressure Offloading Interventions"] 
                            union [Procedure: "Therapeutic Footwear Interventions"]
                    ) FollowUpProcedure
                        where FollowUpProcedure.status ~ 'completed'
                            and FollowUpProcedure.performed.toInterval() during day of "Seven-Day Period Following Qualifying Encounter"
                            and FollowUpProcedure.performed.toInterval() during day of "Measurement Period"
                )
                union (
                    (
                        [ServiceRequest: "Foot Care Referral"]
                            union [ServiceRequest: "Follow Up Within 12 Months"]
                    ) FollowUpServiceRequest
                        where FollowUpServiceRequest.status in { 'active', 'completed' }
                            and FollowUpServiceRequest.intent = 'order'
                            and FollowUpServiceRequest.authoredOn.toInterval() during day of "Seven-Day Period Following Qualifying Encounter"
                            and FollowUpServiceRequest.authoredOn.toInterval() during day of "Measurement Period"
                )
                union (
                    (
                        [DeviceRequest: "Foot Pressure Offloading Devices"]
                            union [DeviceRequest: "Therapeutic Footwear"]
                    ) FollowUpDeviceRequest
                        where FollowUpDeviceRequest.status in { 'active', 'completed' }
                            and FollowUpDeviceRequest.intent = 'order'
                            and FollowUpDeviceRequest.authoredOn.toInterval() during day of "Seven-Day Period Following Qualifying Encounter"
                            and FollowUpDeviceRequest.authoredOn.toInterval() during day of "Measurement Period"
                )
                union (
                    ( 
                        [SimpleObservation: "Under Care of Foot Care Provider"]
                    ) UnderCareObservation
                        where UnderCareObservation.status in { 'final', 'amended', 'corrected' }
                            and UnderCareObservation.effective.toInterval() during day of "Seven-Day Period Following Qualifying Encounter"
                            and UnderCareObservation.effective.toInterval() during day of "Measurement Period"
                )
                union (
                    (
                        "Care Teams with Podiatrist Participant Role"
                            union "Care Teams with Podiatrist PractitionerRole"
                    ) PodiatryCareTeam
                        where PodiatryCareTeam.period overlaps day of "Seven-Day Period Following Qualifying Encounter"
                            and PodiatryCareTeam.period overlaps day of "Measurement Period"
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