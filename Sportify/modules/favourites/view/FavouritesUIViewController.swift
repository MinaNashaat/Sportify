//
//  FavouritesUIViewController.swift
//  Sportify
//
//  Created by Ahmed Salah on 08/05/2026.
//

import UIKit

class FavouritesUIViewController: UIViewController {

    @IBOutlet weak var favouritesTable: UITableView!

    let leagues = [
        "Premier League",
        "La Liga",
        "Serie A",
        "Bundesliga",
        "Ligue 1"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Favourites"
        favouritesTable.separatorStyle = .none

        favouritesTable.delegate = self
        favouritesTable.dataSource = self
        favouritesTable.showsVerticalScrollIndicator = false
        favouritesTable.register(
            UINib(nibName: "FavouritesUITableViewCell", bundle: nil),
            forCellReuseIdentifier: "favouriteCell"
        )
    }
}

extension FavouritesUIViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "favouriteCell",
            for: indexPath
        ) as! FavouritesUITableViewCell

        cell.leagueName.text = leagues[indexPath.row]

        cell.leagueImage.image = UIImage(named: "teamLogo")

        return cell
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
