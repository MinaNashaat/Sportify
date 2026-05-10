//
//  teamDetailsViewController.swift
//  Sportify
//
//  Created by Mina on 09/05/2026.
//

import UIKit

struct RecentMatch {
    let firstTeamName: String
    let firstTeamImage: String
    let secondTeamName: String
    let secondTeamImage: String
    let score: String
    let time: String
}


class teamDetailsViewController: UIViewController {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var stadiumName: UILabel!
    
    @IBOutlet weak var teamNameView: UIView!
    @IBOutlet weak var foundedView: UIView!
    @IBOutlet weak var stadiumView: UIView!
    
    @IBOutlet weak var recentMatchesTale: UITableView!
    
    private let gradientLayer = CAGradientLayer()
    
    let recentMatches: [RecentMatch] = [
        RecentMatch(
            firstTeamName: "Liverpool",
            firstTeamImage: "Football",
            secondTeamName: "Barcelona",
            secondTeamImage: "BascketBall",
            score: "2 - 1",
            time: "Yesterday"
        ),
        
        RecentMatch(
            firstTeamName: "Real Madrid",
            firstTeamImage: "Tennis",
            secondTeamName: "PSG",
            secondTeamImage: "Cracket",
            score: "3 - 3",
            time: "2 Days Ago"
        ),
        
        RecentMatch(
            firstTeamName: "Arsenal",
            firstTeamImage: "Football",
            secondTeamName: "Chelsea",
            secondTeamImage: "Tennis",
            score: "1 - 0",
            time: "Last Week"
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gradientLayer.colors = [
            UIColor(named: "gradientColor")!.cgColor,
            UIColor.white.cgColor
        ]

        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

        view.layer.insertSublayer(gradientLayer, at: 0)

        [teamNameView, foundedView, stadiumView].forEach {
            $0?.layer.cornerRadius = 20
            $0?.clipsToBounds = true
        }
        
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        gradientLayer.frame = view.safeAreaLayoutGuide.layoutFrame
    }
    
    private func setupTableView() {
        
        recentMatchesTale.register(
            UINib(nibName: "recentMatchesTableViewCell", bundle: nil),
            forCellReuseIdentifier: "recentMatchCell"
        )
        
        recentMatchesTale.dataSource = self
        recentMatchesTale.delegate = self
        
        recentMatchesTale.separatorStyle = .none
        recentMatchesTale.backgroundColor = .clear
    }
}

extension teamDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentMatches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "recentMatchCell",
            for: indexPath
        ) as! recentMatchesTableViewCell
        
        let match = recentMatches[indexPath.row]
        
        cell.firstTeamName.text = match.firstTeamName
        cell.secondTeamName.text = match.secondTeamName
        
        cell.firstTeamImage.image = UIImage(named: match.firstTeamImage)
        cell.secondTeamImage.image = UIImage(named: match.secondTeamImage)
        
        cell.score.text = match.score
        cell.myTime.text = match.time
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
