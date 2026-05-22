

import Foundation

struct LiveMatch {
    let id: Int
    let kickoffTime: String
    let status: String
    let isLive: Bool
    let score: Score
    let homeTeam: TeamSummary
    let awayTeam: TeamSummary
    let tournament: Tournament?
    let goals: [Goal]
}

struct Score: Equatable {
    let home: Int
    let away: Int
    let raw: String
}

struct TeamSummary: Equatable {
    let name: String
    let logoURL: URL?
}

struct Tournament: Equatable {
    let league: String
    let round: String?
    let stage: String?
}

struct Goal: Identifiable, Equatable {
    let id = UUID()
    let minute: String
    let half: String?
    let scorer: String
    let assist: String?
    let side: Side
    let scoreAfter: String

    enum Side { case home, away }
}
