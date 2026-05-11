

import Foundation

struct Team: Identifiable, Equatable {
    let id: Int
    let name: String
    let logoURL: URL?
    let players: [Player]
}

struct Player: Identifiable, Equatable {
    let id: Int                    
    let name: String
    let number: Int?
    let imageURL: URL?
    let position: PlayerPosition
}

enum PlayerPosition: String, Equatable {
    case goalkeeper
    case defender
    case midfielder
    case forward
    case unknown

    init(raw: String?) {
        switch raw?.lowercased() {
        case "goalkeepers": self = .goalkeeper
        case "defenders":   self = .defender
        case "midfielders": self = .midfielder
        case "forwards":    self = .forward
        default:            self = .unknown
        }
    }
}
