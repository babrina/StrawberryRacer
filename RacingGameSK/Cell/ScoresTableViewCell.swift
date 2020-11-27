//
//  ScoresTableViewCell.swift
//  RacingGameSK
//
//  Created by Андрей Замиралов on 23.11.2020.
//

import UIKit

class ScoresTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoresLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with name: String, score: Int, date: String ) {
        self.nameLabel.text = "\(name)"
        self.dateLabel.text = "\(date)"
        self.scoresLabel.text = "\(score)"
        
    }


}
