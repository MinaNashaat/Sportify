//
//  LeagueListViewController.swift
//  Sportify
//
//  Created by Ahmed Salah on 10/05/2026.
//

import UIKit

class LeagueListViewController: UIViewController {

    @IBOutlet weak var leaguestTable: UITableView!

    let leagues: [String] = []

    private let emptyView = EmptyLeagueListState()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Leagues"

        leaguestTable.separatorStyle = .none
        leaguestTable.delegate = self
        leaguestTable.dataSource = self
        leaguestTable.showsVerticalScrollIndicator = false

        leaguestTable.register(
            UINib(
                nibName: "LeagueLTableViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: "leagueList"
        )

        setupEmptyView()
        updateUI()
    }

    private func setupEmptyView() {

        view.addSubview(emptyView)

        emptyView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            emptyView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),

            emptyView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            emptyView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            emptyView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
    }

    private func updateUI() {

        let isEmpty = leagues.isEmpty

        leaguestTable.isHidden = isEmpty
        emptyView.isHidden = !isEmpty
    }
}

extension LeagueListViewController : UITableViewDelegate,
                                     UITableViewDataSource{
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return leagues.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "leagueList",
            for: indexPath
        ) as! LeagueLTableViewCell

        cell.leagueName.text = leagues[indexPath.row]
        cell.leagueImage.image = UIImage(named: "teamLogo")

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {

        return 120
    }
}
