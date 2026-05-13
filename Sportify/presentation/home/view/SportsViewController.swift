//
//  SportsViewController.swift
//  Sportify
//
//  Created by Ahmed Salah on 05/05/2026.
//

import UIKit

class SportsViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    var presenter: HomePresenter!
    private let loadingView = LoadingView()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        setupCollectionView()

        presenter?.viewDidLoad()
    }
    let sportsData = SportType.allCases
    private func setupCollectionView() {

        homeCollectionView.register(
            UINib(nibName: "LiveResultCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "liveScore"
        )

        homeCollectionView.register(
            UINib(nibName: "SportsTypeCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "sports"
        )

        homeCollectionView.collectionViewLayout = createLayout()
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        homeCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let hasLiveMatches =
            self.presenter.getLiveMatchesCount() > 0
            if hasLiveMatches && sectionIndex == 0
 {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(250)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.85),
                    heightDimension: .estimated(250)
                )
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitems: [item]
                )

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.interGroupSpacing = 12
                section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16)

                return section
            }  else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)

                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

                sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0)
                section.boundarySupplementaryItems = [sectionHeader]

                return section
            }
        }
    }
}

extension SportsViewController: UICollectionViewDataSource {


    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {

        return presenter.getLiveMatchesCount() > 0 ? 2 : 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {

        if presenter.getLiveMatchesCount() > 0 {

            return section == 0
                ? presenter.getLiveMatchesCount()
                : sportsData.count
        } else {

            return sportsData.count
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        let hasLiveMatches =
        presenter.getLiveMatchesCount() > 0

        if hasLiveMatches && indexPath.section == 0 {

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "liveScore",
                for: indexPath
            ) as! LiveResultCollectionViewCell

            if let match = presenter.getLiveMatch(
                at: indexPath.item
            ) {

                cell.configure(with: match)
            }

            return cell

        } else {

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "sports",
                for: indexPath
            ) as! SportsTypeCollectionViewCell

            let sportIndex =
            hasLiveMatches
                ? indexPath.row
                : indexPath.row

            let sport = sportsData[sportIndex]

            cell.sportText.text = sport.title

            cell.sportImage.image =
            UIImage(named: sport.imageName)

            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader {

            let hasLiveMatches =
            presenter.getLiveMatchesCount() > 0

            let sportsSection =
            hasLiveMatches ? 1 : 0

            if indexPath.section == sportsSection {

                let header =
                collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "header",
                    for: indexPath
                )

                header.subviews.forEach {
                    $0.removeFromSuperview()
                }

                let label = UILabel(frame: header.bounds)

                label.text = "Sports"

                label.font = .boldSystemFont(ofSize: 24)

                header.addSubview(label)

                return header
            }
        }
        return UICollectionReusableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension SportsViewController:
HomeView {

    func showLoading() {

        loadingView.frame = view.bounds

        view.addSubview(loadingView)
    }

    func hideLoading() {

        loadingView.removeFromSuperview()
    }

    func reloadData() {

        homeCollectionView.reloadData()
    }

    func showError(message: String) {

        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            )
        )

        present(alert, animated: true)
    }
}

extension SportsViewController: UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard indexPath.section == 1 else { return }
        presenter.didSelectSport(at: indexPath.row)
//        presenter.didSelectLeague()
    }
}
