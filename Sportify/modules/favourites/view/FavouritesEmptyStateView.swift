//
//  FavouritesEmptyStateView.swift
//  Sportify
//
//  Created by Ahmed Salah on 10/05/2026.
//

import UIKit

class FavouritesEmptyStateView: UIView {

    @IBOutlet weak var contentView: UIView!


    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {

        Bundle.main.loadNibNamed(
            "FavouritesEmptyStateView",
            owner: self,
            options: nil
        )

        addSubview(contentView)

        contentView.frame = bounds
        contentView.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
    }
}
