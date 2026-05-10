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

        cardView.layer.cornerRadius = 20
        cardView.layer.masksToBounds = false

        cardView.backgroundColor = .systemBackground

        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.12
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowRadius = 10

        contentView.backgroundColor = .clear
        backgroundColor = .clear
        leagueNameLabel.font = .systemFont(ofSize: 13, weight: .semibold)

        homeTeamName.font = .systemFont(ofSize: 17, weight: .bold)

        homeTeamLabel.font = .systemFont(ofSize: 17, weight: .bold)

        matchResultLabel.font = .systemFont(ofSize: 28, weight: .heavy)

        matchTimeLabel.textColor = .systemGray
        playersScoresRow.alignment = .top
    }


    func configure(homeGoals: [String], awayGoals: [String]) {

        homeGoalsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        awayGoalsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for goal in homeGoals {
            let label = createGoalLabel(text: goal, alignment: .left)
            homeGoalsStack.addArrangedSubview(label)
        }

        for goal in awayGoals {
            let label = createGoalLabel(text: goal, alignment: .right)
            awayGoalsStack.addArrangedSubview(label)
        }
    }
    private func createGoalLabel(text: String,
                                 alignment: NSTextAlignment) -> UILabel {

        let label = UILabel()

        label.text = "⚽ \(text)"
        label.font = .systemFont(ofSize: 14, weight: .medium)

        label.textColor = .label
        label.numberOfLines = 1

        label.textAlignment = alignment

        label.backgroundColor = UIColor.systemGray6
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true

        label.layoutMargins = UIEdgeInsets(
            top: 6,
            left: 10,
            bottom: 6,
            right: 10
        )

        let container = PaddingLabel()
        container.insets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)

        container.text = label.text
        container.font = label.font
        container.textAlignment = alignment
        container.backgroundColor = UIColor.systemGray6
        container.layer.cornerRadius = 8
        container.layer.masksToBounds = true

        return container
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        homeGoalsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        awayGoalsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
