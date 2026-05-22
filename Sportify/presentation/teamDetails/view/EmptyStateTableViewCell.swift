//
//  EmptyStateTableViewCell.swift
//  Sportify
//
//  Created by Ahmed Salah on 13/05/2026.
//



import UIKit

final class EmptyStateTableViewCell: UITableViewCell {

    static let reuseID = "EmptyStateTableViewCell"


    private let iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor   = UIColor.tertiaryLabel.withAlphaComponent(0.6)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let messageLabel: UILabel = {
        let l = UILabel()
        l.font          = .systemFont(ofSize: 16, weight: .medium)
        l.textColor     = .tertiaryLabel
        l.textAlignment = .center
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle  = .none
        buildLayout()
    }

    required init?(coder: NSCoder) { fatalError("Use programmatic init") }

    // MARK: - Layout

    private func buildLayout() {
        let stack = UIStackView(arrangedSubviews: [iconView, messageLabel])
        stack.axis      = .vertical
        stack.spacing   = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 72),
            iconView.heightAnchor.constraint(equalToConstant: 72),

            stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 48),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -48),
            stack.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 40),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -40),
        ])
    }

    // MARK: - Configure

    func configure(icon: String, message: String) {
        let config = UIImage.SymbolConfiguration(pointSize: 52, weight: .ultraLight)
        iconView.image    = UIImage(systemName: icon, withConfiguration: config)
        messageLabel.text = message
    }
}

