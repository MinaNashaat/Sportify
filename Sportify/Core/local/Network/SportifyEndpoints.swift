//
//  SportifyEndpoints.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//

import Foundation
import Alamofire

enum SportifyEndpoints: Endpoint {

    case leagues(sport: SportType)

    case liveScore(sport: SportType)

    case leagueTeams(sport: SportType,leagueId: Int)

    case leagueEvents(sport: SportType, leagueId: Int, from: String, to: String)

    case teamEvents(sport: SportType, leagueId: Int, teamId: Int, from: String, to: String)

    var path: String {

        switch self {

        case .leagues(let sport),
             .liveScore(let sport),
             .leagueTeams(let sport, _),
             .leagueEvents(let sport, _, _, _),
             .teamEvents(let sport, _, _, _, _):

            return "\(sport.rawValue)/"
        }
    }

    var parameters: Parameters {

        switch self {

        case .leagues:
            return ["met": "Leagues"]

        case .liveScore:
            return ["met": "Livescore","timezone": "Africa/Cairo"]

        case .leagueTeams(_, let leagueId):
            return ["met": "Teams","leagueId": leagueId]

        case .leagueEvents(_,let leagueId, let from, let to):
            return ["met": "Fixtures", "leagueId": leagueId, "from": from, "to": to, "timezone": "Africa/Cairo"]

        case .teamEvents(_, let leagueId, let teamId, let from, let to):

            return ["met": "Fixtures", "leagueId": leagueId, "teamId": teamId, "from": from, "to": to, "timezone": "Africa/Cairo"]
        }
    }
}
