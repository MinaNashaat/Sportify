

import Foundation


struct EventResponseDTO: Decodable {
    let success: Int
    let result: [EventDTO]
}

struct EventDTO: Decodable {
    let eventKey: Int
    let eventDate: String?
    let eventTime: String?
    let eventStatus: String?
    let eventLive: String?
    let eventFinalResult: String?

    let eventHomeTeam: String?
    let eventAwayTeam: String?
    let homeTeamLogo: String?
    let awayTeamLogo: String?

    let leagueName: String?
    let leagueRound: String?
    let stageName: String?

    let goalscorers: [GoalScorerDTO]?

    enum CodingKeys: String, CodingKey {
        case eventKey         = "event_key"
        case eventDate        = "event_date"
        case eventTime        = "event_time"
        case eventStatus      = "event_status"
        case eventLive        = "event_live"
        case eventFinalResult = "event_final_result"
        case eventHomeTeam    = "event_home_team"
        case eventAwayTeam    = "event_away_team"
        case homeTeamLogo     = "home_team_logo"
        case awayTeamLogo     = "away_team_logo"
        case leagueName       = "league_name"
        case leagueRound      = "league_round"
        case stageName        = "stage_name"
        case goalscorers
    }
}


extension EventDTO {

    func toDomain() -> MatchEvent {
        MatchEvent(
            id: eventKey,
            date: eventDate ?? "",
            time: eventTime ?? "",
            state: resolveState(),
            homeTeam: TeamSummary(
                name: eventHomeTeam ?? "",
                logoURL: MappingHelpers.url(homeTeamLogo)
            ),
            awayTeam: TeamSummary(
                name: eventAwayTeam ?? "",
                logoURL: MappingHelpers.url(awayTeamLogo)
            ),
            tournament: MappingHelpers.tournament(
                league: leagueName,
                round: leagueRound,
                stage: stageName
            ),
            goals: (goalscorers ?? []).compactMap { $0.toDomain() }
        )
    }

    private func resolveState() -> MatchState {
        let status = (eventStatus ?? "").trimmingCharacters(in: .whitespaces)
        let isLive = MappingHelpers.bool(eventLive)

        if isLive {
            return .live(minute: status)
        }

        switch status.lowercased() {
        case "finished", "after pen.", "after et.", "ft":
            if let score = MappingHelpers.score(from: eventFinalResult) {
                return .finished(score: score)
            }
            return .other(status: status)

        case "not started", "":
            return .upcoming

        default:
            if let score = MappingHelpers.score(from: eventFinalResult) {
                return .finished(score: score)
            }
            return .other(status: status)
        }
    }
}

extension Array where Element == EventDTO {
    func toDomain() -> [MatchEvent] {
        map { $0.toDomain() }
    }
}
