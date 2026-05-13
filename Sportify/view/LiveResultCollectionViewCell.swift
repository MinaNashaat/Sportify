import UIKit
import Kingfisher

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

        setupUI()
    }

    private func setupUI() {

        cardView.layer.cornerRadius = 20
        cardView.layer.masksToBounds = false

        cardView.backgroundColor = .systemBackground

        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.12
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowRadius = 10

        contentView.backgroundColor = .clear
        backgroundColor = .clear

        playersScoresRow.alignment = .top



        
    }

    func configure(with match: LiveMatch) {

        homeTeamName.text =
        match.homeTeam.name

        homeTeamLabel.text =
        match.awayTeam.name

        matchResultLabel.text =
        match.score.raw


        if match.isLive {
            stopLivePulse()

            matchTimeLabel.text =
            "🔴 LIVE • \(match.kickoffTime)"

            matchTimeLabel.textColor =
            .systemRed

            startLivePulse()

        } else {

            matchTimeLabel.text =
            match.kickoffTime

            matchTimeLabel.textColor =
            .secondaryLabel
        }

        leagueNameLabel.text =
        match.tournament?.league

        homeTeamLogo.kf.setImage(
            with: match.homeTeam.logoURL,
            placeholder: UIImage(named: "teamLogo")
        )

        awayTeamLogo.kf.setImage(
            with: match.awayTeam.logoURL,
            placeholder: UIImage(systemName: "photo")
        )

        configureGoals(match.goals)
    }

    private func configureGoals(
        _ goals: [Goal]
    ) {

        homeGoalsStack.arrangedSubviews
            .forEach { $0.removeFromSuperview() }

        awayGoalsStack.arrangedSubviews
            .forEach { $0.removeFromSuperview() }

        let homeGoals = goals.filter {
            $0.side == .home
        }

        let awayGoals = goals.filter {
            $0.side == .away
        }

        for goal in homeGoals {

            let text =
            "\(goal.scorer) \(goal.minute)'"

            let label = createGoalLabel(
                text: text,
                alignment: .left
            )

            homeGoalsStack.addArrangedSubview(label)
        }

        for goal in awayGoals {

            let text =
            "\(goal.scorer) \(goal.minute)'"

            let label = createGoalLabel(
                text: text,
                alignment: .right
            )

            awayGoalsStack.addArrangedSubview(label)
        }
    }

    private func createGoalLabel(
        text: String,
        alignment: NSTextAlignment
    ) -> UILabel {

        let label = PaddingLabel()

        label.insets = UIEdgeInsets(
            top: 6,
            left: 8,
            bottom: 6,
            right: 8
        )

        label.text = "⚽ \(text)"

        label.font = .systemFont(
            ofSize: 14,
            weight: .medium
        )

        label.textColor = .label

        label.textAlignment = alignment

        label.backgroundColor =
        UIColor.systemGray6

        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true

        return label
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        stopLivePulse()

        homeGoalsStack.arrangedSubviews
            .forEach { $0.removeFromSuperview() }

        awayGoalsStack.arrangedSubviews
            .forEach { $0.removeFromSuperview() }

        homeTeamLogo.image = nil
        awayTeamLogo.image = nil
    }
    private func startLivePulse() {

        let pulse =
        CABasicAnimation(
            keyPath: "opacity"
        )

        pulse.fromValue = 1.0
        pulse.toValue = 0.2

        pulse.duration = 0.75

        pulse.autoreverses = true

        pulse.repeatCount = .infinity

        pulse.timingFunction =
        CAMediaTimingFunction(
            name: .easeInEaseOut
        )

        matchTimeLabel.layer.add(
            pulse,
            forKey: "livePulse"
        )
    }

    private func stopLivePulse() {

        matchTimeLabel.layer.removeAnimation(
            forKey: "livePulse"
        )

        matchTimeLabel.alpha = 1
    }
}
