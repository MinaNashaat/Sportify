
import Foundation


struct LiveMatchResponseDTO: Decodable {
    let success: Int
    let result: [LiveMatchDTO]
}

struct LiveMatchDTO: Decodable {
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

struct GoalScorerDTO: Decodable {
    let time: String?
    let score: String?
    let homeScorer: String?
    let awayScorer: String?
    let homeAssist: String?
    let awayAssist: String?
    let infoTime: String?

    enum CodingKeys: String, CodingKey {
        case time
        case score
        case homeScorer = "home_scorer"
        case awayScorer = "away_scorer"
        case homeAssist = "home_assist"
        case awayAssist = "away_assist"
        case infoTime   = "info_time"
    }
}


extension LiveMatchDTO {

    func toDomain() -> LiveMatch? {
        guard let score = MappingHelpers.score(from: eventFinalResult) else {
            return nil
        }

        return LiveMatch(
            id: eventKey,
            kickoffTime: eventTime ?? "",
            status: eventStatus ?? "",
            isLive: MappingHelpers.bool(eventLive),
            score: score,
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
}

extension Array where Element == LiveMatchDTO {
    func toDomain() -> [LiveMatch] {
        compactMap { $0.toDomain() }
    }
}

extension GoalScorerDTO {

    func toDomain() -> Goal? {
        let home = MappingHelpers.nonEmpty(homeScorer)
        let away = MappingHelpers.nonEmpty(awayScorer)

        let side: Goal.Side
        let scorer: String
        let assist: String?

        if let h = home {
            side = .home
            scorer = h
            assist = MappingHelpers.nonEmpty(homeAssist)
        } else if let a = away {
            side = .away
            scorer = a
            assist = MappingHelpers.nonEmpty(awayAssist)
        } else {
            return nil
        }

        return Goal(
            minute: time ?? "",
            half: MappingHelpers.nonEmpty(infoTime),
            scorer: scorer,
            assist: assist,
            side: side,
            scoreAfter: score ?? ""
        )
    }
}
