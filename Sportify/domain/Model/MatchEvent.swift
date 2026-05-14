

import Foundation

struct MatchEvent: Identifiable, Equatable {
    let id: Int
    let date: String
    let time: String
    let state: MatchState
    let homeTeam: TeamSummary
    let awayTeam: TeamSummary
    let tournament: Tournament?
    let goals: [Goal]
}

enum MatchState: Equatable {
    case upcoming
    case live(minute: String)
    case finished(score: Score)
    case other(status: String)        

    var isLive: Bool {
        if case .live = self { return true }
        return false
    }

    var score: Score? {
        if case .finished(let s) = self { return s }
        return nil
    }
}
