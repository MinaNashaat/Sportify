//
//  teamDetailsViewController.swift
//  Sportify
//
//  Created by Mina on 09/05/2026.
//


import UIKit

final class teamDetailsViewController: UIViewController {


    @IBOutlet weak var MyTable: UITableView!
    @IBOutlet weak var mySegmentController: UISegmentedControl!
    @IBOutlet weak var teamLeague: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!


    var presenter: TeamDetailsPresenter?
    var selectedTeam: Team?


    private var currentSegment: TeamDetailsSegment = .upcoming
    private lazy var loadingOverlay = LoadingView()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSegmentControl()
        setupTableView()
        setupLoadingOverlay()
        configureTeamHeader()
        presenter?.viewDidLoad()
    }


    private func setupView() {
        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .never
    }

    private func setupSegmentControl() {
        mySegmentController.removeAllSegments()
        TeamDetailsSegment.allCases.forEach {
            mySegmentController.insertSegment(
                withTitle: $0.title,
                at: $0.rawValue,
                animated: false
            )
        }
        mySegmentController.selectedSegmentIndex = 0
        mySegmentController.addTarget(
            self,
            action: #selector(segmentDidChange(_:)),
            for: .valueChanged
        )
    }

    private func setupTableView() {
        MyTable.delegate       = self
        MyTable.dataSource     = self
        MyTable.separatorStyle = .none
        MyTable.backgroundColor = .clear
        MyTable.contentInset   = UIEdgeInsets(top: 8, left: 0, bottom: 24, right: 0)
        MyTable.showsVerticalScrollIndicator = false
        MyTable.estimatedRowHeight = 110


        MyTable.register(
            UINib(nibName: "recentMatchesTableViewCell", bundle: nil),
            forCellReuseIdentifier: "teamEventsCell"
        )
        MyTable.register(
            UINib(nibName: "teamPlayerTableViewCell", bundle: nil),
            forCellReuseIdentifier: "teamPlayerCell"
        )
        MyTable.register(
            EmptyStateTableViewCell.self,
            forCellReuseIdentifier: EmptyStateTableViewCell.reuseID
        )
        MyTable.rowHeight = 90
    }

    private func setupLoadingOverlay() {
        loadingOverlay.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingOverlay)
        NSLayoutConstraint.activate([
            loadingOverlay.topAnchor.constraint(equalTo: view.topAnchor),
            loadingOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        loadingOverlay.isHidden = true
    }

    private func configureTeamHeader() {
        guard let team = selectedTeam else { return }

        title          = team.name
        teamName.text  = team.name

        teamLogo.contentMode = .scaleAspectFit
        teamLogo.clipsToBounds = true
        teamLogo.layer.cornerRadius = teamLogo.frame.width / 2

        if let url = team.logoURL {
            // Using Kingfisher — swap for SDWebImage or URLSession if needed
            teamLogo.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "sportscourt.circle.fill")
            )
        }
    }


    @objc private func segmentDidChange(_ sender: UISegmentedControl) {
        guard let segment = TeamDetailsSegment(rawValue: sender.selectedSegmentIndex) else { return }
        currentSegment = segment
        presenter?.didSelectSegment(segment)
    }
}

// MARK: - TeamDetailsView

extension teamDetailsViewController: TeamDetailsView {

    func showLoading() {
        DispatchQueue.main.async { self.loadingOverlay.isHidden = false }
    }

    func hideLoading() {
        DispatchQueue.main.async { self.loadingOverlay.isHidden = true }
    }

    func reloadData() {
        DispatchQueue.main.async { self.MyTable.reloadData() }
    }

    func showError(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Something went wrong",
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource

extension teamDetailsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch currentSegment {
        case .upcoming: return max(presenter?.getUpcomingEventsCount() ?? 0, 1)
        case .recent:   return max(presenter?.getRecentEventsCount()   ?? 0, 1)
        case .players:  return max(selectedTeam?.players.count         ?? 0, 1)
        }
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch currentSegment {

        case .upcoming:

            if (presenter?.getUpcomingEventsCount() ?? 0) == 0 {

                return emptyCell(
                    tableView,
                    indexPath,
                    icon: "calendar.badge.clock",
                    message: "No upcoming matches\nfor the next 15 days"
                )
            }

            return eventCell(
                tableView,
                indexPath,
                segment: .upcoming
            )

        case .recent:

            if (presenter?.getRecentEventsCount() ?? 0) == 0 {

                return emptyCell(
                    tableView,
                    indexPath,
                    icon: "clock.arrow.circlepath",
                    message: "No recent matches\nin the past 15 days"
                )
            }

            return eventCell(
                tableView,
                indexPath,
                segment: .recent
            )

        case .players:

            guard let players = selectedTeam?.players,
                  !players.isEmpty else {

                return emptyCell(
                    tableView,
                    indexPath,
                    icon: "person.3.slash",
                    message: "No players available"
                )
            }

            let cell = tableView.dequeueReusableCell(
                withIdentifier: "teamPlayerCell",
                for: indexPath
            ) as! teamPlayerTableViewCell

            cell.configure(with: players[indexPath.row])

            return cell
        }
    }


    private func eventCell(_ tableView: UITableView,
                           _ indexPath: IndexPath,
                           segment: TeamDetailsSegment) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "teamEventsCell",
            for: indexPath
        ) as! recentMatchesTableViewCell

        let event = segment == .upcoming
            ? presenter?.getUpcomingEvent(at: indexPath.row)
            : presenter?.getRecentEvent(at: indexPath.row)

        if let event {
            cell.configure(with: event)
        }

        return cell
    }


    private func emptyCell(_ tableView: UITableView,
                           _ indexPath: IndexPath,
                           icon: String,
                           message: String) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "EmptyStateTableViewCell",
            for: indexPath
        ) as! EmptyStateTableViewCell

        cell.configure(icon: icon, message: message)

        return cell
    }

    
}


extension teamDetailsViewController: UITableViewDelegate {

//    func tableView(_ tableView: UITableView,
//                   heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let isEmpty: Bool
//        switch currentSegment {
//        case .upcoming: isEmpty = (presenter?.getUpcomingEventsCount() ?? 0) == 0
//        case .recent:   isEmpty = (presenter?.getRecentEventsCount()   ?? 0) == 0
//        case .players:  isEmpty = (selectedTeam?.players.isEmpty ?? true)
//        }
//
//        return isEmpty
//            ? max(tableView.bounds.height - 120, 280)
//            : UITableView.automaticDimension
//    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
