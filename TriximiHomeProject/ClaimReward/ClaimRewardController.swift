//
//  ClaimRewardController.swift
//  TriximiHomeProject
//
//  Created by Vasil Panov on 13.2.21.
//

import UIKit

class ClaimRewardController: UIViewController {
    
    var reward: Reward?
    var redeemModel : RedeemModel?
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var rewardImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageURL = URL(string: self.reward!.image_url!)!
        let imageData = try! Data(contentsOf: imageURL)
        rewardImage.image = UIImage(data: imageData)
        detailsLabel.text = reward?.description
    }
    
    @IBAction func redeemButtonAction(_ sender: Any) {
        performRedeemCall()
    }
    
    func performRedeemCall(){
        
        let json: [String: Any] = ["auth_token": UserModel.token,
                                   "appkey":Constants.appKey,
                                   "reward_id":reward?.id,
                                   "location":580]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        // Prepare URL
        let url = URL(string: Constants.coreURL + "/rewards/claim")
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let _: Void = URLSession.shared.dataTask(with: request, completionHandler: {responseData, response, error in
            // Check for Error
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let responseJSON = try? JSONSerialization.jsonObject(with: responseData!, options:[])
                    if let response = responseJSON as? [String: Any], (response["status"] != nil) == true {
                        self.redeemModel = try? JSONDecoder().decode(RedeemModel.self, from: responseData!)
                        if (self.redeemModel?.status == true)  {
                            self.performSegue(withIdentifier: "redeemSegue", sender: nil)
                        }
                    } else {
                        // Go Back to Reward Page
                    }
                } else {
                    //perform error action
                }
            }
        }).resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "redeemSegue" {
            let redeemRewardController = segue.destination as! RedeemRewardController
            redeemRewardController.reward = redeemModel
        }
    }
}

