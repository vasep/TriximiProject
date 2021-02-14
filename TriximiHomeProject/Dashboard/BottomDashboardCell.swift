//
//  BottomDashboardCell.swift
//  TriximiHomeProject
//
//  Created by Vasil Panov on 12.2.21.
//

import UIKit

class BottomDashboardCell: UITableViewCell {
    
    static let identifier = "BottomDashboardCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    static func nib()->UINib {
        return UINib(nibName: "BottomDashboardCell", bundle: nil)
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
