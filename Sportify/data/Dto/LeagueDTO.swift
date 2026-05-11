

import Foundation


struct LeagueResponseDTO: Decodable {
    let success: Int
    let result: [LeagueDTO]
}

struct LeagueDTO: Decodable {
    let leagueKey: Int
    let leagueName: String?
    let countryKey: Int?
    let countryName: String?
    let leagueLogo: String?
    let countryLogo: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey   = "league_key"
        case leagueName  = "league_name"
        case countryKey  = "country_key"
        case countryName = "country_name"
        case leagueLogo  = "league_logo"
        case countryLogo = "country_logo"
    }
}


extension LeagueDTO {

    func toDomain() -> League? {
        guard let name = MappingHelpers.nonEmpty(leagueName) else { return nil }
        return League(
            id: leagueKey,
            name: name,
            country: MappingHelpers.nonEmpty(countryName),
            logoURL: MappingHelpers.url(leagueLogo),
            countryLogoURL: MappingHelpers.url(countryLogo)
        )
    }
}

extension Array where Element == LeagueDTO {
    func toDomain() -> [League] {
        compactMap { $0.toDomain() }
    }
}
