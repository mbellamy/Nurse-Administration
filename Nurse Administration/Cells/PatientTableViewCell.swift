//
//  PatientTableViewCell.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/30/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import UIKit

class PatientTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
