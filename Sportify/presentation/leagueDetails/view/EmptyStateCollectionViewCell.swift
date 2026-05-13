//
//  EmptyStateCollectionViewCell.swift
//  Sportify
//
//  Created by Ahmed Salah on 13/05/2026.
//



import UIKit

final class EmptyStateCollectionViewCell:
UICollectionViewCell {

    static let reuseID =
    "EmptyStateCollectionViewCell"

    private let iconView: UIImageView = {

        let iv = UIImageView()

        iv.contentMode = .scaleAspectFit

        iv.tintColor =
        UIColor.tertiaryLabel
            .withAlphaComponent(0.6)

        iv.translatesAutoresizingMaskIntoConstraints =
        false

        return iv
    }()

    private let messageLabel: UILabel = {

        let label = UILabel()

        label.font =
        .systemFont(
            ofSize: 16,
            weight: .medium
        )

        label.textColor = .tertiaryLabel

        label.textAlignment = .center

        label.numberOfLines = 0

        label.translatesAutoresizingMaskIntoConstraints =
        false

        return label
    }()

    override init(
        frame: CGRect
    ) {

        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        backgroundColor = .clear

        let stack = UIStackView(
            arrangedSubviews: [
                iconView,
                messageLabel
            ]
        )

        stack.axis = .vertical

        stack.spacing = 16

        stack.alignment = .center

        stack.translatesAutoresizingMaskIntoConstraints =
        false

        contentView.addSubview(stack)

        NSLayoutConstraint.activate([

            iconView.widthAnchor.constraint(
                equalToConstant: 72
            ),

            iconView.heightAnchor.constraint(
                equalToConstant: 72
            ),

            stack.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),

            stack.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),

            stack.leadingAnchor.constraint(
                greaterThanOrEqualTo:
                    contentView.leadingAnchor,
                constant: 32
            ),

            stack.trailingAnchor.constraint(
                lessThanOrEqualTo:
                    contentView.trailingAnchor,
                constant: -32
            )
        ])
    }

    func configure(
        icon: String,
        message: String
    ) {

        let config =
        UIImage.SymbolConfiguration(
            pointSize: 52,
            weight: .ultraLight
        )

        iconView.image =
        UIImage(
            systemName: icon,
            withConfiguration: config
        )

        messageLabel.text = message
    }
}
