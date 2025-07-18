library CMS56FHIRFuncStatHipReplacement version '1.1.000'

using QICore version '6.0.0'

include FHIRHelpers version '4.4.000' called FHIRHelpers
include QICoreCommon version '4.0.000' called QICoreCommon
include SupplementalDataElements version '5.1.000' called SDE
include Hospice version '6.15.000' called Hospice
include Status version '1.13.000' called Status

codesystem "LOINC": 'http://loinc.org'
codesystem "CPT": 'http://www.ama-assn.org/go/cpt'
codesystem "SNOMEDCT": 'http://snomed.info/sct'

valueset "Lower Body Fractures Excluding Ankle and Foot": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.1178'
valueset "Malignant Neoplasms of Lower and Unspecified Limbs": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.1180'
valueset "Mechanical Complications Excluding Upper Body": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.1182'
valueset "Office Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1001'
valueset "Virtual Encounter": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1089'
valueset "Outpatient Consultation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1008'
valueset "Partial Arthroplasty of Hip": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.1184'
valueset "Primary THA Procedure": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.198.12.1006'
valueset "Removal, Revision and Supplement Procedures of the Lower Body and Spine": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.1189'
valueset "Telephone Visits": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1080'

code "Activities of daily living score [HOOS]": '72095-3' from "LOINC" display 'Activities of daily living score [HOOS]'
code "Dead (finding)": '419099009' from "SNOMEDCT" display 'Dead (finding)'
code "Pain score [HOOS]": '72097-9' from "LOINC" display 'Pain score [HOOS]'
code "Postoperative follow-up visit, normally included in the surgical package, to indicate that an evaluation and management service was performed during a postoperative period for a reason(s) related to the original procedure": '99024' from "CPT" display 'Postoperative follow-up visit, normally included in the surgical package, to indicate that an evaluation and management service was performed during a postoperative period for a reason(s) related to the original procedure'
code "PROMIS-10 Global Mental Health (GMH) score T-score": '71969-0' from "LOINC" display 'PROMIS-10 Global Mental Health (GMH) score T-score'
code "PROMIS-10 Global Physical Health (GPH) score T-score": '71971-6' from "LOINC" display 'PROMIS-10 Global Physical Health (GPH) score T-score'
code "Quality of life score [HOOS]": '72093-8' from "LOINC" display 'Quality of life score [HOOS]'
code "Severe cognitive impairment (finding)": '702956004' from "SNOMEDCT" display 'Severe cognitive impairment (finding)'
code "Sport-recreation score [HOOS]": '72094-6' from "LOINC" display 'Sport-recreation score [HOOS]'
code "Symptoms score [HOOS]": '72096-1' from "LOINC" display 'Symptoms score [HOOS]'
code "Total interval score [HOOSJR]": '82323-7' from "LOINC" display 'Total interval score [HOOSJR]'
code "VR-12 Mental component summary (MCS) score - oblique method T-score": '72026-8' from "LOINC" display 'VR-12 Mental component summary (MCS) score - oblique method T-score'
code "VR-12 Mental component summary (MCS) score - orthogonal method T-score": '72028-4' from "LOINC" display 'VR-12 Mental component summary (MCS) score - orthogonal method T-score'
code "VR-12 Physical component summary (PCS) score - oblique method T-score": '72025-0' from "LOINC" display 'VR-12 Physical component summary (PCS) score - oblique method T-score'
code "VR-12 Physical component summary (PCS) score - orthogonal method T-score": '72027-6' from "LOINC" display 'VR-12 Physical component summary (PCS) score - orthogonal method T-score'

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
  "Has Qualifying Encounter"
    and exists ("Total Hip Arthroplasty Procedure")
    and AgeInYearsAt(date from start of "Measurement Period") >= 19

define "Has Qualifying Encounter":
  exists ((([Encounter: "Outpatient Consultation"]
        union [Encounter: "Office Visit"]
        union ([Encounter] E
            where exists ((E.type ) T
                where T ~ "Postoperative follow-up visit, normally included in the surgical package, to indicate that an evaluation and management service was performed during a postoperative period for a reason(s) related to the original procedure"
            )
        )
        union [Encounter: "Telephone Visits"]
        union [Encounter: "Virtual Encounter"]
    ).isEncounterPerformedLocal()) ValidEncounters
      where ValidEncounters.period during day of Interval["August 1 Year Prior to the Measurement Period", end of "Measurement Period"]
  )

define "August 1 Year Prior to the Measurement Period":
  DateTime((year from start of "Measurement Period" - 1), 8, 1, 0, 0, 0, 0, 0)

define "Total Hip Arthroplasty Procedure":
  (([Procedure: "Primary THA Procedure"]).isProcedurePerformed()) THAProcedure
    where THAProcedure.performed.toInterval() starts during day of Interval["November 1 Two Years Prior to the Measurement Period", "October 31 Year Prior to the Measurement Period"]

define "November 1 Two Years Prior to the Measurement Period":
  DateTime((year from start of "Measurement Period" - 2), 11, 1, 0, 0, 0, 0, 0)

define "October 31 Year Prior to the Measurement Period":
  DateTime((year from start of "Measurement Period" - 1), 10, 31, 23, 59, 59, 999, 0)

define "Denominator":
  "Initial Population"

define "Denominator Exclusions":
  Hospice."Has Hospice Services"
    or "Has Severe Cognitive Impairment"
    or "Has Total Hip Arthroplasty with 1 or More Lower Body Fractures"
    or "Has Partial Hip Arthroplasty Procedure"
    or "Has Revision Hip Arthroplasty Procedure or Implanted Device or Prosthesis Removal Procedure"
    or "Has Malignant Neoplasm of Lower and Unspecified Limbs"
    or "Has Mechanical Complication"
    or "Has More Than One Elective Primary Total Hip Arthroplasty Performed"
    or "Death Within 300 Days of the THA Procedure"

define "Has Severe Cognitive Impairment":
  exists ([ConditionProblemsHealthConcerns: "Severe cognitive impairment (finding)"]
    union [ConditionEncounterDiagnosis: "Severe cognitive impairment (finding)"]) Dementia
    where Dementia.prevalenceInterval() overlaps day of "Measurement Period"

define "Has Total Hip Arthroplasty with 1 or More Lower Body Fractures":
  exists ("Total Hip Arthroplasty Procedure" THAProcedure
      with ([ConditionEncounterDiagnosis: "Lower Body Fractures Excluding Ankle and Foot"]
        union [ConditionProblemsHealthConcerns: "Lower Body Fractures Excluding Ankle and Foot"]) LowerBodyFracture
        such that LowerBodyFracture.prevalenceInterval() starts 48 hours or less on or before start of THAProcedure.performed.toInterval() 
  )

define "Has Partial Hip Arthroplasty Procedure":
  exists ((([Procedure: "Partial Arthroplasty of Hip"]).isProcedurePerformed()) PartialTHAProcedure
      with "Total Hip Arthroplasty Procedure" THAProcedure
        such that PartialTHAProcedure.performed.toInterval() during day of THAProcedure.performed.toInterval() 
  )

define "Has Revision Hip Arthroplasty Procedure or Implanted Device or Prosthesis Removal Procedure":
  exists ("Total Hip Arthroplasty Procedure" THAProcedure
      with (([Procedure: "Removal, Revision and Supplement Procedures of the Lower Body and Spine"]).isProcedurePerformed()) RevisionTHAProcedure
        such that RevisionTHAProcedure.performed.toInterval() during day of THAProcedure.performed.toInterval() 
  )

define "Has Malignant Neoplasm of Lower and Unspecified Limbs":
  exists (([ConditionProblemsHealthConcerns: "Malignant Neoplasms of Lower and Unspecified Limbs"]
      union [ConditionEncounterDiagnosis: "Malignant Neoplasms of Lower and Unspecified Limbs"]) MalignantNeoplasm
      with "Total Hip Arthroplasty Procedure" THAProcedure
        such that MalignantNeoplasm.prevalenceInterval() overlaps day of THAProcedure.performed.toInterval() 
  )

define "Has Mechanical Complication":
  exists (([ConditionEncounterDiagnosis: "Mechanical Complications Excluding Upper Body"]
      union [ConditionProblemsHealthConcerns: "Mechanical Complications Excluding Upper Body"]) MechanicalComplications
      with "Total Hip Arthroplasty Procedure" THAProcedure
        such that MechanicalComplications.prevalenceInterval() overlaps day of THAProcedure.performed.toInterval() 
  )

define "Has More Than One Elective Primary Total Hip Arthroplasty Performed":
  exists ("Total Hip Arthroplasty Procedure" THAProcedure
      with (([Procedure: "Primary THA Procedure"]).isProcedurePerformed()) ElectiveTHAProcedure
        such that THAProcedure.id !~ ElectiveTHAProcedure.id
          and start of ElectiveTHAProcedure.performed.toInterval() during day of Interval[(start of THAProcedure.performed.toInterval()) - 1 year, (start of THAProcedure.performed.toInterval()) + 1 year]
  )

define "Death Within 300 Days of the THA Procedure":
  exists "Total Hip Arthroplasty Procedure" THAProcedure
    where date from Patient.deceased during day of Interval[date from start of THAProcedure.performed.toInterval(), date from start of THAProcedure.performed.toInterval() + 300 days]

define "Numerator":
  ("Has THA with Initial and Follow Up HOOS Assessments")
    or ("Has THA with Initial and Follow Up HOOSJr Assessments")
    or ("Has THA with Initial and Follow Up PROMIS10 Assessments")
    or ("Has THA with Initial and Follow Up VR12 Oblique Assessments")
    or ("Has THA with Initial and Follow Up VR12 Orthogonal Assessments")

define "Has THA with Initial and Follow Up HOOS Assessments":
  exists (("Total Hip Arthroplasty Procedure" THAProcedure
      return THAProcedure.performed.toInterval()) TotalHip
      with "Date HOOS Total Assessment Completed" InitialHipAssessmentHOOS
        such that TotalHip starts 90 days or less on or after day of InitialHipAssessmentHOOS
      with "Date HOOS Total Assessment Completed" FollowUpHipAssessmentHOOS
        such that date from FollowUpHipAssessmentHOOS during day of Interval[date from end of TotalHip + 300 days, date from end of TotalHip + 425 days]
  )

define "Date HOOS Total Assessment Completed":
  from
    (([ObservationScreeningAssessment: "Quality of life score [HOOS]"]).isAssessmentPerformed()) HOOSLifeQuality,
    (([ObservationScreeningAssessment: "Sport-recreation score [HOOS]"]).isAssessmentPerformed()) HOOSSport,
    (([ObservationScreeningAssessment: "Activities of daily living score [HOOS]"]).isAssessmentPerformed()) HOOSActivityScore,
    (([ObservationScreeningAssessment: "Symptoms score [HOOS]"]).isAssessmentPerformed()) HOOSSymptoms,
    (([ObservationScreeningAssessment: "Pain score [HOOS]"]).isAssessmentPerformed()) HOOSPain
    let HOOSLifeQualityDate: date from start of HOOSLifeQuality.effective.toInterval(),
    HOOSSportDate: date from start of HOOSSport.effective.toInterval(),
    HOOSActivityScoreDate: date from start of HOOSActivityScore.effective.toInterval(),
    HOOSSymptomsDate: date from start of HOOSSymptoms.effective.toInterval(),
    HOOSPainDate: date from start of HOOSPain.effective.toInterval() 
    where HOOSLifeQualityDate same day as HOOSSportDate
      and (HOOSSport as ObservationScreeningAssessment).value is not null
      and HOOSLifeQualityDate same day as HOOSActivityScoreDate
      and (HOOSActivityScore as ObservationScreeningAssessment).value is not null
      and HOOSLifeQualityDate same day as HOOSSymptomsDate
      and (HOOSSymptoms as ObservationScreeningAssessment).value is not null
      and HOOSLifeQualityDate same day as HOOSPainDate
      and (HOOSPain as ObservationScreeningAssessment).value is not null
      and (HOOSLifeQuality as ObservationScreeningAssessment).value is not null
    return Max({ HOOSLifeQualityDate, HOOSSportDate, HOOSActivityScoreDate, HOOSSymptomsDate, HOOSPainDate })

define "Has THA with Initial and Follow Up HOOSJr Assessments":
  exists (("Total Hip Arthroplasty Procedure" THAProcedure
      return THAProcedure.performed.toInterval()) TotalHip
      with "Date HOOSJr Total Assessment Completed" InitialHipAssessment
        such that TotalHip starts 90 days or less on or after day of InitialHipAssessment
      with "Date HOOSJr Total Assessment Completed" FollowUpHipAssessment
        such that date from FollowUpHipAssessment during day of Interval[date from end of TotalHip + 300 days, date from end of TotalHip + 425 days]
  )

define "Date HOOSJr Total Assessment Completed":
  ((([ObservationScreeningAssessment: "Total interval score [HOOSJR]"]).isAssessmentPerformed()) HOOSJr
    where (HOOSJr as ObservationScreeningAssessment).value is not null) DocumentedHOOSJr
    return date from start of DocumentedHOOSJr.effective.toInterval() 

define "Has THA with Initial and Follow Up PROMIS10 Assessments":
  exists (("Total Hip Arthroplasty Procedure" THAProcedure
      return THAProcedure.performed.toInterval()) TotalHip
      with "Date PROMIS10 Total Assessment Completed" InitialHipAssessmentPROMIS10
        such that TotalHip starts 90 days or less on or after day of InitialHipAssessmentPROMIS10
      with "Date PROMIS10 Total Assessment Completed" FollowUpHipAssessmentPROMIS10
        such that date from FollowUpHipAssessmentPROMIS10 during day of Interval[date from end of TotalHip + 300 days, date from end of TotalHip + 425 days]
  )

define "Date PROMIS10 Total Assessment Completed":
  from
    (([ObservationScreeningAssessment: "PROMIS-10 Global Mental Health (GMH) score T-score"]).isAssessmentPerformed()) PROMIS10MentalScore,
    (([ObservationScreeningAssessment: "PROMIS-10 Global Physical Health (GPH) score T-score"]).isAssessmentPerformed()) PROMIS10PhysicalScore
    let PROMIS10MentalScoreDate: date from start of PROMIS10MentalScore.effective.toInterval(),
    PROMIS10PhysicalScoreDate: date from start of PROMIS10PhysicalScore.effective.toInterval() 
    where PROMIS10MentalScoreDate same day as PROMIS10PhysicalScoreDate
      and (PROMIS10PhysicalScore as ObservationScreeningAssessment).value is not null
      and (PROMIS10MentalScore as ObservationScreeningAssessment).value is not null
    return Max({ PROMIS10MentalScoreDate, PROMIS10PhysicalScoreDate })

define "Has THA with Initial and Follow Up VR12 Oblique Assessments":
  exists (("Total Hip Arthroplasty Procedure" THAProcedure
      return THAProcedure.performed.toInterval()) TotalHip
      with "Date VR12 Oblique Total Assessment Completed" InitialHipAssessmentOblique
        such that TotalHip starts 90 days or less on or after day of InitialHipAssessmentOblique
      with "Date VR12 Oblique Total Assessment Completed" FollowUpHipAssessmentOblique
        such that date from FollowUpHipAssessmentOblique during day of Interval[date from end of TotalHip + 300 days, date from end of TotalHip + 425 days]
  )

define "Date VR12 Oblique Total Assessment Completed":
  from
    (([ObservationScreeningAssessment: "VR-12 Mental component summary (MCS) score - oblique method T-score"]).isAssessmentPerformed()) VR12MentalAssessment,
    (([ObservationScreeningAssessment: "VR-12 Physical component summary (PCS) score - oblique method T-score"]).isAssessmentPerformed()) VR12PhysicalAssessment
    let VR12MentalAssessmentDate: date from start of VR12MentalAssessment.effective.toInterval(),
    VR12PhysicalAssessmentDate: date from start of VR12PhysicalAssessment.effective.toInterval() 
    where VR12MentalAssessmentDate same day as VR12PhysicalAssessmentDate
      and (VR12MentalAssessment as ObservationScreeningAssessment).value is not null
      and (VR12PhysicalAssessment as ObservationScreeningAssessment).value is not null
    return Max({ VR12MentalAssessmentDate, VR12PhysicalAssessmentDate })

define "Has THA with Initial and Follow Up VR12 Orthogonal Assessments":
  exists (("Total Hip Arthroplasty Procedure" THAProcedure
      return THAProcedure.performed.toInterval()) TotalHip
      with "Date VR12 Orthogonal Total Assessment Completed" InitialHipAssessmentOrthogonal
        such that TotalHip starts 90 days or less on or after day of InitialHipAssessmentOrthogonal
      with "Date VR12 Orthogonal Total Assessment Completed" FollowUpHipAssessmentOrthogonal
        such that date from FollowUpHipAssessmentOrthogonal during day of Interval[date from end of TotalHip + 300 days, date from end of TotalHip + 425 days]
  )

define "Date VR12 Orthogonal Total Assessment Completed":
  from
    (([ObservationScreeningAssessment: "VR-12 Mental component summary (MCS) score - orthogonal method T-score"]).isAssessmentPerformed()) VR12MentalAssessment,
    (([ObservationScreeningAssessment: "VR-12 Physical component summary (PCS) score - orthogonal method T-score"]).isAssessmentPerformed()) VR12PhysicalAssessment
    let VR12MentalAssessmentDate: date from start of VR12MentalAssessment.effective.toInterval(),
    VR12PhysicalAssessmentDate: date from start of VR12PhysicalAssessment.effective.toInterval() 
    where VR12MentalAssessmentDate same day as VR12PhysicalAssessmentDate
      and (VR12MentalAssessment as ObservationScreeningAssessment).value is not null
      and (VR12PhysicalAssessment as ObservationScreeningAssessment).value is not null
    return Max({ VR12MentalAssessmentDate, VR12PhysicalAssessmentDate })

define fluent function isEncounterPerformedLocal(Enc List<Encounter>):
  Enc E
    where E.status in { 'finished', 'in-progress' }