//
//  SportsViewController.swift
//  Sportify
//
//  Created by Ahmed Salah on 05/05/2026.
//

import UIKit

class SportsViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }

    private func setupCollectionView() {

        // Cells
        homeCollectionView.register(
            UINib(nibName: "LiveResultCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "liveScore"
        )

        homeCollectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "sports"
        )

        homeCollectionView.collectionViewLayout = createLayout()
        homeCollectionView.dataSource = self
    }
    func createLayout() -> UICollectionViewLayout {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(250) // 🔥 dynamic height
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)

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
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)

        return UICollectionViewCompositionalLayout(section: section)
    }
}


extension SportsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "liveScore",
            for: indexPath
        ) as! LiveResultCollectionViewCell

        let homeGoals = ["Salah 23'", "Trezeguet 55'"]

        let awayGoals = indexPath.item == 0
            ? ["Messi 10'"]
            : ["Messi 10'", "Mbappe 30'", "Neymar 70'"]

        cell.configure(homeGoals: homeGoals, awayGoals: awayGoals)

        return cell
    }
}
