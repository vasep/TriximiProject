//
//  RedeemRewardController.swift
//  TriximiHomeProject
//
//  Created by Vasil Panov on 13.2.21.
//

import UIKit

class RedeemRewardController: UIViewController {

    var reward: RedeemModel?
    
    @IBOutlet weak var redeemTimerLabel: UILabel!
    @IBOutlet weak var topDescriptionLabel: UILabel!
    @IBOutlet weak var redeemCodeLabel: UILabel!
    @IBOutlet weak var bottomDescriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        redeemCodeLabel.text = String((reward?.reward_code)!)
        redeemTimerLabel.text = String((reward?.reward_timer)!)
    }
    
    @IBAction func doneBtnAction(_ sender: Any) {
        self.performSegue(withIdentifier: "rewardSegue", sender: nil)
    }
}
