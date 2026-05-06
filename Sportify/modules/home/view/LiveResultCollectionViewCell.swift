//
//  LiveResultCollectionViewCell.swift
//  Sportify
//
//  Created by Ahmed Salah on 05/05/2026.
//

import UIKit

class LiveResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var awayGoalsStack: UIStackView!
    @IBOutlet weak var homeGoalsStack: UIStackView!
    @IBOutlet weak var playersScoresRow: UIStackView!
    @IBOutlet weak var awayTeamPlayerScores: UILabel!
    @IBOutlet weak var homeTeamPlayerScored: UILabel!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLogo: UIImageView!
    @IBOutlet weak var matchResultLabel: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var matchTimeLabel: UILabel!
    @IBOutlet weak var homeTeamLogo: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.translatesAutoresizingMaskIntoConstraints = false


    }


    func configure(homeGoals: [String], awayGoals: [String]) {

        homeGoalsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        awayGoalsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for goal in homeGoals {
            let label = UILabel()
            label.text = "⚽ \(goal)"
            label.font = .systemFont(ofSize: 16)
            homeGoalsStack.addArrangedSubview(label)
        }

        for goal in awayGoals {
            let label = UILabel()
            label.text = "⚽ \(goal)"
            label.font = .systemFont(ofSize: 16)
            label.textAlignment = .right
            awayGoalsStack.addArrangedSubview(label)
        }

        setNeedsLayout()
        layoutIfNeeded()
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        layer.shadowPath = UIBezierPath(
//            roundedRect: cardView.frame,
//            cornerRadius: 16
//        ).cgPath
//        layer.shadowOpacity = 0.1
//        layer.shadowRadius = 6
//    }


    override func prepareForReuse() {
        super.prepareForReuse()

        homeGoalsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        awayGoalsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
