//
//  recentMatchesTableViewCell.swift
//  Sportify
//
//  Created by Mina on 09/05/2026.
//

import UIKit

class recentMatchesTableViewCell: UITableViewCell {
    @IBOutlet weak var secondTeamImage: UIImageView!
    @IBOutlet weak var secondTeamName: UILabel!
    @IBOutlet weak var myTime: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var firstTeamImage: UIImageView!
    @IBOutlet weak var firstTeamName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
