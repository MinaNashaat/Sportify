//
//  TeamDetailsPresenterImpl.swift
//  Sportify
//
//  Created by Ahmed Salah on 12/05/2026.
//


import Foundation

final class TeamDetailsPresenterImpl: TeamDetailsPresenter {


    weak var view: TeamDetailsView?
    private let repository: TeamDetailsRepository
    private let router: AppRouter


    private var upcomingEvents: [MatchEvent] = []
    private var recentEvents:   [MatchEvent] = []

    private var hasLoadedRecent = false
    private var isLoadingRecent = false


    var sport:    SportType = .football
    var leagueId: Int       = 0
    var teamId:   Int       = 0


    init(
        view: TeamDetailsView,
        repository: TeamDetailsRepository,
        router: AppRouter
    ) {
        self.view       = view
        self.repository = repository
        self.router     = router
    }


    func viewDidLoad() {
        fetchEvents(for: .upcoming)
    }


    func didSelectSegment(_ segment: TeamDetailsSegment) {
        switch segment {
        case .upcoming, .players:
            view?.reloadData()

        case .recent:
            guard !hasLoadedRecent, !isLoadingRecent else {
                view?.reloadData()
                return
            }
            fetchEvents(for: .recent)
        }
    }


    func getUpcomingEventsCount() -> Int { upcomingEvents.count }
    func getRecentEventsCount()   -> Int { recentEvents.count   }

    func getUpcomingEvent(at index: Int) -> MatchEvent? {
        upcomingEvents[safe: index]
    }

    func getRecentEvent(at index: Int) -> MatchEvent? {
        recentEvents[safe: index]
    }


    private func fetchEvents(for segment: TeamDetailsSegment) {
        guard segment != .players else { return }

        let (from, to) = buildDateRange(for: segment)
        if segment == .recent { isLoadingRecent = true }

        view?.showLoading()

        Task { [weak self] in
            guard let self = self else { return }

            do {
                let events = try await repository.getTeamEvents(
                    sport:    sport,
                    leagueId: leagueId,
                    teamId:   teamId,
                    from:     from,
                    to:       to
                )

                if segment == .upcoming {
                    self.upcomingEvents = events
                } else {
                    self.recentEvents    = events
                    self.hasLoadedRecent = true
                    self.isLoadingRecent = false
                }

                await MainActor.run {
                    self.view?.hideLoading()
                    self.view?.reloadData()
                }

            } catch {
                if segment == .recent { self.isLoadingRecent = false }

                await MainActor.run {
                    self.view?.hideLoading()
                    self.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }


    private func buildDateRange(for segment: TeamDetailsSegment) -> (String, String) {
        let fmt      = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let now      = Date()
        let cal      = Calendar.current

        switch segment {
        case .upcoming:
            let to = cal.date(byAdding: .day, value: 15, to: now) ?? now
            return (fmt.string(from: now), fmt.string(from: to))

        case .recent:
            let from      = cal.date(byAdding: .day, value: -15, to: now) ?? now
            let yesterday = cal.date(byAdding: .day, value:  -1, to: now) ?? now
            return (fmt.string(from: from), fmt.string(from: yesterday))

        case .players:
            return ("", "")
        }
    }
}


private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
