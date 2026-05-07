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
    let sportsData = [
        Sport(name: "Football", image: "Football"),
        Sport(name: "Tennis", image: "Tennis"),
        Sport(name: "Basketball", image: "BascketBall"),
        Sport(name: "Cricket", image: "Cracket")
    ]
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
        homeCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in

            if sectionIndex == 0 {
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


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 5 : sportsData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        if indexPath.section == 0 {
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
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sports", for: indexPath) as! SportsTypeCollectionViewCell
            let sport = sportsData[indexPath.row]

            cell.sportText.text = sport.name
            cell.sportImage.image = UIImage(named: sport.image)

            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader && indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)

            header.subviews.forEach { $0.removeFromSuperview() }
            let label = UILabel(frame: header.bounds)
            label.text = "Sports"
            label.font = .boldSystemFont(ofSize: 24)

            header.addSubview(label)

            return header
        }
        return UICollectionReusableView()
    }
}

