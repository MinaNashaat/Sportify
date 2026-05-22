//
//  recentMatchesTableViewCell.swift
//  Sportify
//
//  Created by Mina on 09/05/2026.
//
//


import UIKit
import Kingfisher

class recentMatchesTableViewCell: UITableViewCell {


    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var awayTeamLogo: UIImageView!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var vsOrResultText: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var leagueNameAndRound: UILabel!
    @IBOutlet weak var matchStatusText: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        styleCard()
        styleTeamLogos()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        matchStatusText.layer.removeAnimation(forKey: "livePulse")
        matchStatusText.alpha = 1
        homeTeamImage.image   = nil
        awayTeamLogo.image    = nil
    }


    private func styleCard() {
        backgroundColor              = .clear
        contentView.backgroundColor  = .clear
        selectionStyle               = .none


        cardView.layer.cornerRadius  = 18
        cardView.clipsToBounds       = false
        cardView.backgroundColor     = .secondarySystemGroupedBackground

        cardView.layer.shadowColor   = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.10
        cardView.layer.shadowRadius  = 10
        cardView.layer.shadowOffset  = CGSize(width: 0, height: 3)

        homeTeamName.font         = .systemFont(ofSize: 13, weight: .semibold)
        homeTeamName.numberOfLines = 2

        awayTeamName.font         = .systemFont(ofSize: 13, weight: .semibold)
        awayTeamName.numberOfLines = 2

        vsOrResultText.font       = .systemFont(ofSize: 20, weight: .bold)
        vsOrResultText.textAlignment = .center

        leagueNameAndRound.font   = .systemFont(ofSize: 11, weight: .medium)
        leagueNameAndRound.textColor = .secondaryLabel

        matchStatusText.font      = .systemFont(ofSize: 11, weight: .semibold)
    }

    private func styleTeamLogos() {
        for logo in [homeTeamImage, awayTeamLogo] {
            logo?.contentMode        = .scaleAspectFit
            logo?.clipsToBounds      = true
            logo?.layer.cornerRadius = 4
        }
    }


    func configure(with event: MatchEvent) {

        homeTeamName.text = event.homeTeam.name
        awayTeamName.text = event.awayTeam.name

        homeTeamImage.kf.setImage(
            with: event.homeTeam.logoURL,
            placeholder: UIImage(systemName: "shield")
        )
        awayTeamLogo.kf.setImage(
            with: event.awayTeam.logoURL,
            placeholder: UIImage(systemName: "shield")
        )

        leagueNameAndRound.text = event.tournament?.league ?? "—"

        applyMatchState(event.state, date: event.date, time: event.time)
    }


    private func applyMatchState(
        _ state: MatchState,
        date: String,
        time: String
    ) {
        stopLivePulse()

        switch state {

        case .live(let minute):
            vsOrResultText.text      = "LIVE"
            vsOrResultText.textColor = .systemRed

            matchStatusText.text      = "🔴 LIVE • \(minute)'"
            matchStatusText.textColor = .systemRed
            startLivePulse()

        case .finished(let score):
            vsOrResultText.text      = "\(score.home) – \(score.away)"
            vsOrResultText.textColor = .label

            matchStatusText.text      = "FT  •  \(shortDate(date))"
            matchStatusText.textColor = .secondaryLabel

        case .upcoming:
            vsOrResultText.text      = "vs"
            vsOrResultText.textColor = UIColor.secondaryLabel.withAlphaComponent(0.5)

            matchStatusText.text      = "\(shortDate(date))  \(time)"
            matchStatusText.textColor = .secondaryLabel

        case .other(let status):
            vsOrResultText.text      = "–"
            vsOrResultText.textColor = .secondaryLabel

            matchStatusText.text      = status
            matchStatusText.textColor = .secondaryLabel
        }
    }


    private func startLivePulse() {
        let pulse           = CABasicAnimation(keyPath: "opacity")
        pulse.fromValue     = 1.0
        pulse.toValue       = 0.2
        pulse.duration      = 0.75
        pulse.autoreverses  = true
        pulse.repeatCount   = .infinity
        pulse.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        matchStatusText.layer.add(pulse, forKey: "livePulse")
    }

    private func stopLivePulse() {
        matchStatusText.layer.removeAnimation(forKey: "livePulse")
        matchStatusText.alpha = 1
    }

    // MARK: - Helpers

    private func shortDate(_ raw: String) -> String {
        let input  = DateFormatter(); input.dateFormat  = "yyyy-MM-dd"
        let output = DateFormatter(); output.dateFormat = "MMM d"
        return input.date(from: raw).map { output.string(from: $0) } ?? raw
    }
}
