//
//  SportsTypeCollectionViewCell.swift
//  Sportify
//
//  Created by Ahmed Salah on 05/05/2026.
//

import UIKit

class SportsTypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sportText: UILabel!
    @IBOutlet weak var spordCardBackground: UIView!
    @IBOutlet weak var sportNameBack: UIView!
    @IBOutlet weak var sportImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellDesign()
    }

    private func setupCellDesign() {

        spordCardBackground.layer.cornerRadius = 20
        spordCardBackground.layer.masksToBounds = false
        spordCardBackground.layer.shadowColor = UIColor.black.cgColor
        spordCardBackground.layer.shadowOpacity = 0.15
        spordCardBackground.layer.shadowOffset = CGSize(width: 0, height: 5)
        spordCardBackground.layer.shadowRadius = 10


        sportImage.layer.cornerRadius = 20
        sportImage.clipsToBounds = true

        setupBlurEffect()
    }

    private func setupBlurEffect() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)

        blurEffectView.frame = sportNameBack.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        sportNameBack.backgroundColor = .clear
        sportNameBack.insertSubview(blurEffectView, at: 0)

        
        sportNameBack.layer.cornerRadius = 20
        sportNameBack.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        sportNameBack.clipsToBounds = true
    }
}
