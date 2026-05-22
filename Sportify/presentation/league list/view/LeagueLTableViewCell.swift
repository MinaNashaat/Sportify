//
//  LeagueLTableViewCell.swift
//  Sportify
//
//  Created by Ahmed Salah on 10/05/2026.
//

import UIKit

class LeagueLTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var favouriteBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

        setupCardUI()
        setupButton()
    }

    private func setupCardUI() {

        backgroundColor = .clear
        contentView.backgroundColor = .clear

        cardView.backgroundColor = .white

        cardView.layer.cornerRadius = 20

        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.12
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowRadius = 8

        cardView.layer.masksToBounds = false

        leagueImage.layer.cornerRadius = 14
        leagueImage.clipsToBounds = true
        leagueImage.layer.borderWidth = 1
        leagueImage.layer.borderColor = UIColor.systemGray5.cgColor
    }

    private func setupButton() {

        let image = UIImage(
            systemName: "arrow.right.circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 20,
                weight: .regular
            )
        )

        favouriteBtn.setImage(image, for: .normal)

        favouriteBtn.tintColor = UIColor(named: "PrimaryColor")

        favouriteBtn.backgroundColor = .clear

        favouriteBtn.imageView?.contentMode = .scaleAspectFit

        favouriteBtn.contentHorizontalAlignment = .center
        favouriteBtn.contentVerticalAlignment = .center

        favouriteBtn.layer.cornerRadius = 18
    }

    @IBAction func favouriteButton(_ sender: UIButton) {

        UIView.animate(withDuration: 0.15,
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { _ in
            UIView.animate(withDuration: 0.15) {
                sender.transform = .identity
            }
        }
    }

}
