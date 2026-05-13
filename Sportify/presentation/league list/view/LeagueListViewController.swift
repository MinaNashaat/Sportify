//
//  LeagueListViewController.swift
//  Sportify
//
//  Created by Ahmed Salah on 10/05/2026.
//

import UIKit
import Kingfisher

class LeagueListViewController: UIViewController {
    
    @IBOutlet weak var leaguestTable: UITableView!
    var presenter: LeagueListPresenter!
    private let loadingView = LoadingView()
    private let emptyView = EmptyLeagueListState()
    var viewController: UIViewController { return self }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = presenter? .sportType.title ?? "Leagues"
        leaguestTable.separatorStyle = .none
        leaguestTable.delegate = self
        leaguestTable.dataSource = self
        leaguestTable.showsVerticalScrollIndicator = false
        leaguestTable.register(
            UINib(nibName: "LeagueLTableViewCell", bundle: nil),
            forCellReuseIdentifier: "leagueList"
        )
        setupEmptyView()
        presenter?.viewDidLoad()
    }

    private func setupEmptyView() {
        view.addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func updateUI() {

        let isEmpty = presenter.leagues.isEmpty

        leaguestTable.isHidden = isEmpty

        emptyView.isHidden = !isEmpty
    }
}

extension LeagueListViewController: LeagueListView {
    func showLoading() {

        leaguestTable.isHidden = true
        emptyView.isHidden = true

        loadingView.frame = view.bounds

        view.addSubview(loadingView)
    }
    func hideLoading() {

        loadingView.removeFromSuperview()

        updateUI()
    }
    func reloadData() {
        leaguestTable.reloadData()
    }
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension LeagueListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.leagues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "leagueList", for: indexPath
        ) as! LeagueLTableViewCell

        let league = presenter.leagues[indexPath.row]
        cell.leagueName.text = league.name

        cell.leagueImage.kf.setImage(
            with: league.logoURL,
            placeholder: UIImage(named: "teamLogo")
        )

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectLeague(at: indexPath.row)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
