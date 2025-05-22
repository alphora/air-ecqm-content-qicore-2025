library CareTeamBug version '0.0.000'

using QICore version '6.0.0'

include FHIRHelpers version '4.4.000' called FHIRHelpers

context Patient

// define "Care Teams with Podiatrist Participant Role Participant":
//     [CareTeam] CT
//         return CT.participant
    
define "Care Teams with Podiatrist Participant Role Participant.Role":
    [CareTeam] CT
        return CT.participant.role
    
// define "Care Teams with Podiatrist Participant Role Participant.Role 2":
//     [CareTeam] CT
//         return (CT.participant) p
//           return p.role
    
// define "Care Teams with Podiatrist Participant Role Participant.Role 3":
//     [CareTeam] CT
//         return (CT.participant) p
//           return (p.role) r
//             return r
    
// define "Care Teams with Podiatrist Participant Role Participant.Role 4":
//     [CareTeam] CT
//         return (singleton from CT.participant).role