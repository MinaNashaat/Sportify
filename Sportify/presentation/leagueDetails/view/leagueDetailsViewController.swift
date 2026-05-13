//
//  leagueDetailsViewController.swift
//  Sportify
//
//  Created by Mina on 10/05/2026.
//

import UIKit
import Kingfisher


private enum Section: Int, CaseIterable {
    case liveMatches
    case recentMatches
    case teamPlayers

    var title: String {
        switch self {
        case .liveMatches:   return "Upcoming"
        case .recentMatches: return "Latest Results"
        case .teamPlayers:   return "Teams"
        }
    }
}


class leagueDetailsViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueCountry: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    var presenter: LeagueDetailsPresenter!

    private let loadingView = LoadingView()


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        setupCollectionView()
        presenter.viewDidLoad()
    }


    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate   = self

        collectionView.register(
            UINib(nibName: "LiveResultCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "upcomingCell"
        )
        collectionView.register(
            UINib(nibName: "recentMatchesCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "latestCell"
        )
        collectionView.register(
            UINib(nibName: "teamPlayerCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "teamsCell"
        )
        collectionView.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "sectionHeader"
        )

        collectionView.setCollectionViewLayout(makeLayout(), animated: false)
    }

    private func populateHeader() {
        leagueName.text    = presenter.league.name
        leagueCountry.text = presenter.league.country ?? ""
        leagueImage.kf.setImage(
            with: presenter.league.logoURL,
            placeholder: UIImage(named: "teamLogo")
        )
    }


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

    private func makeHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(44)
        )
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: size,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }

    private func makeLiveMatchesSection() -> NSCollectionLayoutSection {
        let item  = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.88), heightDimension: .estimated(250)),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing           = 12
        section.contentInsets               = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)
        section.boundarySupplementaryItems  = [makeHeader()]
        return section
    }

    private func makeRecentMatchesSection() -> NSCollectionLayoutSection {
        let item  = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(93))
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(93)),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing          = 8
        section.contentInsets              = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)
        section.boundarySupplementaryItems = [makeHeader()]
        return section
    }

    private func makeTeamPlayersSection() -> NSCollectionLayoutSection {
        let item  = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(165), heightDimension: .absolute(178))
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(600), heightDimension: .absolute(178)),
            subitems: [item]
        )
        group.interItemSpacing = .fixed(12)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets              = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 24, trailing: 16)
        section.boundarySupplementaryItems = [makeHeader()]
        return section
    }
}


extension leagueDetailsViewController: LeagueDetailsView {

    var viewController: UIViewController { self }

    func showLoading() {
        loadingView.frame = view.bounds
        view.addSubview(loadingView)
    }

    func hideLoading() {
        loadingView.removeFromSuperview()
    }

    func reloadData() {
        populateHeader()
        collectionView.reloadData()
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


extension leagueDetailsViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .liveMatches:   return presenter.upcomingMatches.count
        case .recentMatches: return presenter.recentMatches.count
        case .teamPlayers:   return presenter.teams.count
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "sectionHeader",
            for: indexPath
        )
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

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch Section(rawValue: indexPath.section)! {

        case .liveMatches:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "upcomingCell", for: indexPath
            ) as! LiveResultCollectionViewCell

            let event = presenter.upcomingMatches[indexPath.item]

            let liveMatch = LiveMatch(
                id: event.id,
                kickoffTime: "\(event.date) \(event.time)",
                status: {
                    if case .live(let min) = event.state { return min }
                    return event.time
                }(),
                isLive: event.state.isLive,
                score: event.state.score ?? Score(home: 0, away: 0, raw: "- : -"),
                homeTeam: event.homeTeam,
                awayTeam: event.awayTeam,
                tournament: event.tournament,
                goals: event.goals
            )

            cell.configure(with: liveMatch)
            return cell

        case .recentMatches:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "latestCell", for: indexPath
            ) as! recentMatchesCollectionViewCell

            let event = presenter.recentMatches[indexPath.item]
            let scoreText: String = {
                if case .finished(let s) = event.state { return s.raw }
                return "-"
            }()

            cell.firstTeamName.text  = event.homeTeam.name
            cell.secondTeamName.text = event.awayTeam.name
            cell.score.text          = scoreText
            cell.myTime.text         = event.date

            cell.firstTeamImage.kf.setImage(
                with: event.homeTeam.logoURL,
                placeholder: UIImage(named: "teamLogo")
            )
            cell.secondTeamImage.kf.setImage(
                with: event.awayTeam.logoURL,
                placeholder: UIImage(named: "teamLogo")
            )

            return cell

        case .teamPlayers:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "teamsCell", for: indexPath
            ) as! teamPlayerCollectionViewCell

            let team = presenter.teams[indexPath.item]
            cell.playerName.text = team.name
            cell.playerImage.kf.setImage(
                with: team.logoURL,
                placeholder: UIImage(named: "teamLogo")
            )

            return cell
        }
    }
}


extension leagueDetailsViewController: UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {

        guard Section(rawValue: indexPath.section) == .teamPlayers else {
            return
        }

        let selectedTeam = presenter.teams[indexPath.item]

        let router = AppRouterImpl()

        router.navigateToTeamDetails(
            from: self,
            team: selectedTeam,
            sport: presenter.sportType
        )
    }
}
