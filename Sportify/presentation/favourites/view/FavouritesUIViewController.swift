
import UIKit
import Kingfisher

class FavouritesUIViewController:
UIViewController {

    @IBOutlet weak var favouritesTable:
    UITableView!

    private let emptyView =
    FavouritesEmptyStateView()

    var presenter:
    FavouritesPresenter!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?
            .navigationBar
            .prefersLargeTitles = true
        emptyView.tabBarController = tabBarController
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

        presenter.viewDidLoad()
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

        let isEmpty =
        presenter.leagues.isEmpty

        favouritesTable.isHidden = isEmpty

        emptyView.isHidden = !isEmpty
    }
}

extension FavouritesUIViewController:
FavouritesView {

    func renderLeagues() {

        favouritesTable.reloadData()

        updateUI()
    }

    func showDeleteAlert(
        index: Int
    ) {

        let alert =
        UIAlertController(
            title: "Delete League",
            message: "Are you sure you want to remove this league from favourites?",
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel
            )
        )

        alert.addAction(
            UIAlertAction(
                title: "Delete",
                style: .destructive,
                handler: { _ in

                    self.presenter.deleteLeague(
                        at: index
                    )
                }
            )
        )

        present(
            alert,
            animated: true
        )
    }
}

extension FavouritesUIViewController:
UITableViewDelegate,
UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        presenter.leagues.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell =
        tableView.dequeueReusableCell(
            withIdentifier: "favouriteCell",
            for: indexPath
        ) as! FavouritesUITableViewCell

        let league =
        presenter.leagues[indexPath.row]

        cell.leagueName.text =
        league.leagueTitle

        cell.leagueImage.kf.setImage(
            with: URL(string: league.leagueImage),
            placeholder: UIImage(named: "teamLogo")
        )

        cell.deleteAction = { [weak self] in

            self?.showDeleteAlert(
                index: indexPath.row
            )
        }

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        presenter.didSelectLeague(
            at: indexPath.row
        )
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {

        120
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {

        let delete =
        UIContextualAction(
            style: .destructive,
            title: "Delete"
        ) { [weak self] _, _, completion in

            self?.showDeleteAlert(
                index: indexPath.row
            )

            completion(true)
        }

        return UISwipeActionsConfiguration(
            actions: [delete]
        )
    }
}
