//
//  TopDashboardCell.swift
//  TriximiHomeProject
//
//  Created by Vasil Panov on 12.2.21.
//

import UIKit

class TopDashboardCell: UITableViewCell {

    static let identifier = "TopDashboardCell"

    static func nib()->UINib {
        return UINib(nibName: "TopDashboardCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
