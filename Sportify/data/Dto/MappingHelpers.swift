

import Foundation

enum MappingHelpers {

    static func parseScore(_ raw: String?) -> (home: Int, away: Int)? {
        guard let raw = raw?.trimmingCharacters(in: .whitespaces), !raw.isEmpty else {
            return nil
        }
        let parts = raw
            .split(whereSeparator: { $0 == "-" || $0 == ":" })
            .map { $0.trimmingCharacters(in: .whitespaces) }

        guard parts.count == 2,
              let h = Int(parts[0]),
              let a = Int(parts[1]) else {
            return nil
        }
        return (h, a)
    }

    static func score(from raw: String?) -> Score? {
        guard let parsed = parseScore(raw) else { return nil }
        return Score(home: parsed.home, away: parsed.away, raw: raw ?? "")
    }

    static func url(_ raw: String?) -> URL? {
        guard let raw = raw?.trimmingCharacters(in: .whitespaces),
              !raw.isEmpty else { return nil }
        return URL(string: raw)
    }

    static func bool(_ raw: String?) -> Bool {
        raw == "1"
    }

    static func nonEmpty(_ raw: String?) -> String? {
        guard let raw = raw?.trimmingCharacters(in: .whitespaces),
              !raw.isEmpty else { return nil }
        return raw
    }


    static func tournament(league: String?, round: String?, stage: String?) -> Tournament? {
        guard let league = nonEmpty(league) else { return nil }
        return Tournament(
            league: league,
            round: nonEmpty(round),
            stage: nonEmpty(stage)
        )
    }
}
