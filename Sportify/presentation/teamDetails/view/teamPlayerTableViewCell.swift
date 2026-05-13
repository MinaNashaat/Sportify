import UIKit
import Kingfisher

class teamPlayerTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var myCardView: UIView!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerPosition: UILabel!

    // MARK: - Badge

    private let numberBadge: UILabel = {

        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .bold)

        label.textAlignment = .center
        label.textColor = .white

        label.backgroundColor = .systemBlue

        label.clipsToBounds = true
        label.layer.cornerRadius = 11

        return label
    }()

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        setupCell()
        setupCard()
        setupImage()
        setupLabels()
        setupBadge()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        myCardView.layer.shadowPath =
        UIBezierPath(
            roundedRect: myCardView.bounds,
            cornerRadius: 18
        ).cgPath
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        playerImage.image = nil
        numberBadge.isHidden = true
    }

    // MARK: - Setup

    private func setupCell() {

        backgroundColor = .clear
        contentView.backgroundColor = .clear

        selectionStyle = .none

        clipsToBounds = false
        contentView.clipsToBounds = false
    }

    private func setupCard() {

        myCardView.backgroundColor = .secondarySystemBackground

        myCardView.layer.cornerRadius = 18

        myCardView.layer.shadowColor = UIColor.black.cgColor
        myCardView.layer.shadowOpacity = 0.08
        myCardView.layer.shadowRadius = 8
        myCardView.layer.shadowOffset = CGSize(width: 0, height: 2)

        myCardView.clipsToBounds = false
    }

    private func setupImage() {

        playerImage.contentMode = .scaleAspectFill

        playerImage.layer.cornerRadius = 28
        playerImage.layer.masksToBounds = true

        playerImage.backgroundColor = .systemGray5

        playerImage.tintColor = .systemBlue
    }

    private func setupLabels() {

        playerName.font = .systemFont(ofSize: 17, weight: .semibold)
        playerName.textColor = .label
        playerName.numberOfLines = 1

        playerPosition.font = .systemFont(ofSize: 11, weight: .bold)

        playerPosition.textAlignment = .center
        playerPosition.textColor = .white

        playerPosition.layer.cornerRadius = 8
        playerPosition.layer.masksToBounds = true
    }

    private func setupBadge() {

        contentView.addSubview(numberBadge)

        NSLayoutConstraint.activate([

            numberBadge.widthAnchor.constraint(equalToConstant: 22),

            numberBadge.heightAnchor.constraint(equalToConstant: 22),

            numberBadge.trailingAnchor.constraint(
                equalTo: playerImage.trailingAnchor,
                constant: 2
            ),

            numberBadge.bottomAnchor.constraint(
                equalTo: playerImage.bottomAnchor,
                constant: 2
            )
        ])

        numberBadge.layer.zPosition = 999
    }

    // MARK: - Configure

    func configure(with player: Player) {

        playerName.text = player.name

        let info = player.position.displayInfo

        playerPosition.text = info.title
        playerPosition.backgroundColor = info.color

        if let number = player.number {

            numberBadge.text = "\(number)"
            numberBadge.backgroundColor = info.color
            numberBadge.isHidden = false

        } else {

            numberBadge.isHidden = true
        }

        if let url = player.imageURL {

            playerImage.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "person.fill")
            )

        } else {

            playerImage.image = UIImage(systemName: "person.fill")
        }
    }
}

// MARK: - Position Style

private extension PlayerPosition {

    var displayInfo: (title: String, color: UIColor) {

        switch self {

        case .goalkeeper:
            return ("GK", .systemOrange)

        case .defender:
            return ("DEF", .systemBlue)

        case .midfielder:
            return ("MID", .systemGreen)

        case .forward:
            return ("FWD", .systemRed)

        case .unknown:
            return ("UNK", .systemGray)
        }
    }
}
