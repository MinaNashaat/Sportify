//
//  FavouritesUIViewController.swift
//  Sportify
//

import UIKit

class FavouritesUIViewController: UIViewController {

    @IBOutlet weak var favouritesTable: UITableView!

    let leagues: [String] = []

    private let emptyView = FavouritesEmptyStateView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Favourites"

        favouritesTable.separatorStyle = .none
        favouritesTable.delegate = self
        favouritesTable.dataSource = self
        favouritesTable.showsVerticalScrollIndicator = false

        favouritesTable.register(
            UINib(
                nibName: "FavouritesUITableViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: "favouriteCell"
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

        favouritesTable.isHidden = isEmpty
        emptyView.isHidden = !isEmpty
    }
}

extension FavouritesUIViewController:
UITableViewDelegate,
UITableViewDataSource {

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
            withIdentifier: "favouriteCell",
            for: indexPath
        ) as! FavouritesUITableViewCell

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
