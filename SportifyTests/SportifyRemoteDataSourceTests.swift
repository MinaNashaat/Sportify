//
//  SportifyRemoteDataSourceTests.swift
//  Sportify
//
//  Created by Ahmed Salah on 16/05/2026.
//

//
//  SportifyRemoteDataSourceTests.swift
//  SportifyTests
//

import XCTest
@testable import Sportify

final class SportifyRemoteDataSourceTests: XCTestCase {

    var sut: SportifyRemoteDataSourceImpl!

    override func setUp() {
        super.setUp()
        sut = SportifyRemoteDataSourceImpl()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }


    func test_getLeagues_football_returnsNonEmptyResult() {
        let expectation = expectation(description: "Football leagues fetched")

        Task {
            do {
                let result = try await sut.getLeagues(sport: .football)
                XCTAssertNotNil(result, "Response should not be nil")
                XCTAssertFalse(result.result.isEmpty , "Leagues list should not be empty")
                expectation.fulfill()
            } catch {
                XCTFail("Request failed with error: \(error.localizedDescription)")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 15)
    }

    func test_getLeagues_basketball_returnsNonEmptyResult() {
        let expectation = expectation(description: "Basketball leagues fetched")

        Task {
            do {
                let result = try await sut.getLeagues(sport: .basketball)
                XCTAssertNotNil(result)
                XCTAssertFalse(result.result.isEmpty , "Leagues list should not be empty")
                expectation.fulfill()
            } catch {
                XCTFail("Request failed with error: \(error.localizedDescription)")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 15)
    }


    func test_getLiveMatches_football_returnsValidResponse() {
        let expectation = expectation(description: "Live football matches fetched")

        Task {
            do {
                let result = try await sut.getLiveMatches(sport: .football)

                XCTAssertNotNil(result, "Response should not be nil")
                expectation.fulfill()
            } catch {
                XCTFail("Request failed with error: \(error.localizedDescription)")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 15)
    }

    func test_getLiveMatches_cricket_returnsValidResponse() {
        let expectation = expectation(description: "Live cricket matches fetched")

        Task {
            do {
                let result = try await sut.getLiveMatches(sport: .cricket)
                XCTAssertNotNil(result)
                expectation.fulfill()
            } catch {
                XCTFail("Request failed with error: \(error.localizedDescription)")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 15)
    }


    func test_getLeagueEvents_football_returnsEvents() {
        let expectation = expectation(description: "League events fetched")

        Task {
            do {
                let result = try await sut.getLeagueEvents(
                    sport: .football,
                    leagueId: 148,
                    from: "2025-01-01",
                    to: "2025-05-01"
                )
                XCTAssertNotNil(result, "Response should not be nil")
                XCTAssertFalse(result.result.isEmpty , "Events should not be empty for a valid league and range")
                expectation.fulfill()
            } catch {
                XCTFail("Request failed with error: \(error.localizedDescription)")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 15)
    }

    func test_getLeagueEvents_invalidLeagueId_returnsEmptyOrHandlesGracefully() {
        let expectation = expectation(description: "League events with invalid ID")

        Task {
            do {
                let result = try await sut.getLeagueEvents(
                    sport: .football,
                    leagueId: -1,
                    from: "2025-01-01",
                    to: "2025-05-01"
                )

                XCTAssertNotNil(result)
                expectation.fulfill()
            } catch {
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 15)
    }


    func test_getTeamEvents_football_returnsEvents() {
        let expectation = expectation(description: "Team events fetched")


        Task {
            do {
                let result = try await sut.getTeamEvents(
                    sport: .football,
                    leagueId: 207,
                    teamId: 79,
                    from: "2025-01-01",
                    to: "2025-05-01"
                )
                XCTAssertNotNil(result, "Response should not be nil")
                XCTAssertFalse(result.result.isEmpty , "Team events should not be empty")
                expectation.fulfill()
            } catch {
                XCTFail("Request failed with error: \(error.localizedDescription)")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 15)
    }


    func test_getLeagueTeams_football_returnsTeams() {
        let expectation = expectation(description: "League teams fetched")

        Task {
            do {
                let result = try await sut.getLeagueTeams(sport: .football, leagueId: 148)
                XCTAssertNotNil(result, "Response should not be nil")
                XCTAssertFalse(result.result.isEmpty , "Teams list should not be empty")
                expectation.fulfill()
            } catch {
                XCTFail("Request failed with error: \(error.localizedDescription)")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 15)
    }

    


    func test_getLeagueEvents_futureRange_returnsEmptyOrValid() {
        let expectation = expectation(description: "Future date range events")

        Task {
            do {
                let result = try await sut.getLeagueEvents(
                    sport: .football,
                    leagueId: 148,
                    from: "2099-01-01",
                    to: "2099-12-31"
                )

                XCTAssertNotNil(result)
                expectation.fulfill()
            } catch {
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 15)
    }
}
