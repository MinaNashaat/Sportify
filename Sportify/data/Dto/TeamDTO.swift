

import Foundation


struct TeamResponseDTO: Decodable {
    let success: Int
    let result: [TeamDTO]
}

struct TeamDTO: Decodable {
    let teamKey: Int
    let teamName: String?
    let teamLogo: String?
    let players: [TeamPlayerDTO]?

    enum CodingKeys: String, CodingKey {
        case teamKey  = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
    }
}

struct TeamPlayerDTO: Decodable {
    let playerKey: Int?
    let playerName: String?
    let playerNumber: String?
    let playerImage: String?
    let playerType: String?

    enum CodingKeys: String, CodingKey {
        case playerKey    = "player_key"
        case playerName   = "player_name"
        case playerNumber = "player_number"
        case playerImage  = "player_image"
        case playerType   = "player_type"
    }
}


extension TeamDTO {

    func toDomain() -> Team? {
        guard let name = MappingHelpers.nonEmpty(teamName) else { return nil }
        return Team(
            id: teamKey,
            name: name,
            logoURL: MappingHelpers.url(teamLogo),
            players: (players ?? []).compactMap { $0.toDomain() }
        )
    }
}

extension Array where Element == TeamDTO {
    func toDomain() -> [Team] {
        compactMap { $0.toDomain() }
    }
}

extension TeamPlayerDTO {

    func toDomain() -> Player? {
        guard let key = playerKey, key != 0,
              let name = MappingHelpers.nonEmpty(playerName) else {
            return nil
        }
        return Player(
            id: key,
            name: name,
            number: Int(playerNumber ?? ""),
            imageURL: MappingHelpers.url(playerImage),
            position: PlayerPosition(raw: playerType)
        )
    }
}
