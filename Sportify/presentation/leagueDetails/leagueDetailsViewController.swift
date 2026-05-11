//
//  leagueDetailsViewController.swift
//  Sportify
//
//  Created by Mina on 10/05/2026.
//

import UIKit

// MARK: - Data Models

struct DummyLiveMatch {
    let leagueName: String
    let matchTime: String
    let homeTeamName: String
    let awayTeamName: String
    let homeTeamLogo: UIImage?
    let awayTeamLogo: UIImage?
    let score: String
    let homeGoals: [String]
    let awayGoals: [String]
}

struct RecentMatch2 {
    let firstTeamName: String
    let secondTeamName: String
    let firstTeamImage: UIImage?
    let secondTeamImage: UIImage?
    let score: String
    let time: String
}

struct TeamPlayer {
    let name: String
    let image: UIImage?
}

// MARK: - Section enum

private enum Section: Int, CaseIterable {
    case liveMatches
    case recentMatches
    case teamPlayers

    var title: String {
        switch self {
        case .liveMatches:   return "Upcoming"
        case .recentMatches: return "Latest Results"
        case .teamPlayers:   return "Team Players"
        }
    }
}

// MARK: - View Controller

class leagueDetailsViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueCountry: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: Mock Data

    var liveMatches: [DummyLiveMatch] = [
        DummyLiveMatch(
            leagueName: "Premier League",
            matchTime: "LIVE • 71'",
            homeTeamName: "ASC",
            awayTeamName: "EVE",
            homeTeamLogo: UIImage(named: "teamLogo"),
            awayTeamLogo: UIImage(named: "teamLogo"),
            score: "3 - 2",
            homeGoals: ["Salah 12'", "Mané 45'", "Firmino 68'"],
            awayGoals: ["Calvert-Lewin 14'", "Gray 55'"]
        ),
        DummyLiveMatch(
            leagueName: "La Liga",
            matchTime: "LIVE • 34'",
            homeTeamName: "BAR",
            awayTeamName: "RMA",
            homeTeamLogo: UIImage(named: "teamLogo"),
            awayTeamLogo: UIImage(named: "teamLogo"),
            score: "1 - 0",
            homeGoals: ["Pedri 22'"],
            awayGoals: []
        )
    ]

    var recentMatches: [RecentMatch2] = [
        RecentMatch2(firstTeamName: "JUV", secondTeamName: "MIL",
                     firstTeamImage: UIImage(named: "teamLogo"),
                     secondTeamImage: UIImage(named: "teamLogo"),
                     score: "3 - 1", time: "FT"),
        RecentMatch2(firstTeamName: "INT", secondTeamName: "ROM",
                     firstTeamImage: UIImage(named: "teamLogo"),
                     secondTeamImage: UIImage(named: "teamLogo"),
                     score: "0 - 0", time: "FT"),
        RecentMatch2(firstTeamName: "NAP", secondTeamName: "LAZ",
                     firstTeamImage: UIImage(named: "teamLogo"),
                     secondTeamImage: UIImage(named: "teamLogo"),
                     score: "2 - 1", time: "FT")
    ]

    var teamPlayers: [TeamPlayer] = [
        TeamPlayer(name: "M. Salah",    image: UIImage(named: "teamLogo")),
        TeamPlayer(name: "V. van Dijk", image: UIImage(named: "teamLogo")),
        TeamPlayer(name: "A. Arnold",   image: UIImage(named: "teamLogo")),
        TeamPlayer(name: "A. Becker",   image: UIImage(named: "teamLogo")),
        TeamPlayer(name: "L. Díaz",     image: UIImage(named: "teamLogo")),
        TeamPlayer(name: "D. Núñez",    image: UIImage(named: "teamLogo"))
    ]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        populateHeader()
    }

    // MARK: - Setup

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate   = self

        let liveNib = UINib(nibName: "LiveResultCollectionViewCell", bundle: nil)
        collectionView.register(liveNib, forCellWithReuseIdentifier: "upcomingCell")

        let recentNib = UINib(nibName: "recentMatchesCollectionViewCell", bundle: nil)
        collectionView.register(recentNib, forCellWithReuseIdentifier: "latestCell")

        let playerNib = UINib(nibName: "teamPlayerCollectionViewCell", bundle: nil)
        collectionView.register(playerNib, forCellWithReuseIdentifier: "teamsCell")

        // ── Register section header ─────────────────────────────────────────
        collectionView.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "sectionHeader"
        )

        collectionView.setCollectionViewLayout(makeLayout(), animated: false)
        collectionView.reloadData()
    }

    private func populateHeader() {
        leagueName.text    = "Serie A"
        leagueCountry.text = "Italy"
        leagueImage.image  = UIImage(named: "teamLogo")
    }

    // MARK: - Compositional Layout

    private func makeLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let section = Section(rawValue: sectionIndex) else { return nil }
            switch section {
            case .liveMatches:   return self?.makeLiveMatchesSection()
            case .recentMatches: return self?.makeRecentMatchesSection()
            case .teamPlayers:   return self?.makeTeamPlayersSection()
            }
        }
    }

    /// Shared helper — creates a 44pt tall section header
    private func makeHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .absolute(44))
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: size,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }

    private func makeLiveMatchesSection() -> NSCollectionLayoutSection {
        let itemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let item      = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.88),
                                               heightDimension: .estimated(250))
        let group     = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section   = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing           = 12
        section.contentInsets               = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)
        section.boundarySupplementaryItems  = [makeHeader()]
        return section
    }

    private func makeRecentMatchesSection() -> NSCollectionLayoutSection {
        let itemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(93))
        let item      = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(93))
        let group     = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section   = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing          = 8
        section.contentInsets              = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)
        section.boundarySupplementaryItems = [makeHeader()]
        return section
    }

    private func makeTeamPlayersSection() -> NSCollectionLayoutSection {
        let itemSize  = NSCollectionLayoutSize(widthDimension: .absolute(165),
                                               heightDimension: .absolute(178))
        let item      = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(600),
                                               heightDimension: .absolute(178))
        let group     = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(12)

        let section   = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets              = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 24, trailing: 16)
        section.boundarySupplementaryItems = [makeHeader()]
        return section
    }
}

// MARK: - UICollectionViewDataSource

extension leagueDetailsViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .liveMatches:   return liveMatches.count
        case .recentMatches: return recentMatches.count
        case .teamPlayers:   return teamPlayers.count
        }
    }

    // ── Section Headers ───────────────────────────────────────────────────────
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "sectionHeader",
            for: indexPath
        )

        // Remove old label from a previous reuse cycle
        header.subviews.forEach { $0.removeFromSuperview() }

        let label = UILabel()
        label.text = Section(rawValue: indexPath.section)?.title
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: header.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: header.centerYAnchor)
        ])

        return header
    }

    // ── Cells ─────────────────────────────────────────────────────────────────
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section(rawValue: indexPath.section)! {

        case .liveMatches:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "upcomingCell",
                for: indexPath) as! LiveResultCollectionViewCell

            let dummyMatch =
            liveMatches[indexPath.item]

            let mappedGoals: [Goal] =

            dummyMatch.homeGoals.map {

                Goal(
                    minute: "",
                    half: nil,
                    scorer: $0,
                    assist: nil,
                    side: .home,
                    scoreAfter: ""
                )

            } +

            dummyMatch.awayGoals.map {

                Goal(
                    minute: "",
                    half: nil,
                    scorer: $0,
                    assist: nil,
                    side: .away,
                    scoreAfter: ""
                )
            }

            let liveMatch = LiveMatch(
                id: indexPath.item,
                kickoffTime: dummyMatch.matchTime,
                status: "Live",
                isLive: true,
                score: Score(
                    home: 0,
                    away: 0,
                    raw: dummyMatch.score
                ),
                homeTeam: TeamSummary(
                    name: dummyMatch.homeTeamName,
                    logoURL: nil
                ),
                awayTeam: TeamSummary(
                    name: dummyMatch.awayTeamName,
                    logoURL: nil
                ),
                tournament: Tournament(
                    league: dummyMatch.leagueName,
                    round: nil,
                    stage: nil
                ),
                goals: mappedGoals
            )

            cell.configure(with: liveMatch)
            return cell

        case .recentMatches:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "latestCell",
                for: indexPath) as! recentMatchesCollectionViewCell

            let match = recentMatches[indexPath.item]
            cell.firstTeamName.text    = match.firstTeamName
            cell.secondTeamName.text   = match.secondTeamName
            cell.firstTeamImage.image  = match.firstTeamImage
            cell.secondTeamImage.image = match.secondTeamImage
            cell.score.text            = match.score
            cell.myTime.text           = match.time
            return cell

        case .teamPlayers:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "teamsCell",
                for: indexPath) as! teamPlayerCollectionViewCell

            let player = teamPlayers[indexPath.item]
            cell.playerName.text   = player.name
            cell.playerImage.image = player.image
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate

extension leagueDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        // Handle tap per section if needed
    }
}
