//
//  TeamDetailsPresenter.swift
//  Sportify
//
//  Created by Ahmed Salah on 12/05/2026.
//



import Foundation


enum TeamDetailsSegment: Int, CaseIterable {
    case upcoming = 0
    case recent   = 1
    case players  = 2

    var title: String {
        switch self {
        case .upcoming: return "Upcoming"
        case .recent:   return "Recent"
        case .players:  return "Players"
        }
    }
}





protocol TeamDetailsPresenter: AnyObject {

    var sport:    SportType { get set }
    var leagueId: Int       { get set }
    var teamId:   Int       { get set }

    func viewDidLoad()
    func didSelectSegment(_ segment: TeamDetailsSegment)

    func getUpcomingEventsCount() -> Int
    func getRecentEventsCount()   -> Int

    func getUpcomingEvent(at index: Int) -> MatchEvent?
    func getRecentEvent(at index: Int)   -> MatchEvent?
}
