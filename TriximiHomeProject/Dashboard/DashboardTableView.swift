//
//  DashboardTableView.swift
//  TriximiHomeProject
//
//  Created by Vasil Panov on 12.2.21.
//

import UIKit

class DashboardTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerLabelTxt: UILabel!
    var rewardsModelData: [Reward]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        headerLabelTxt.font = UIFont(name: "Old Typography", size: 30) // put here the correct font name

        self.tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        self.tableView.register(TopDashboardCell.nib(), forCellReuseIdentifier: TopDashboardCell.identifier)
        self.tableView.register(BottomDashboardCell.nib(), forCellReuseIdentifier: BottomDashboardCell.identifier)
        // Do any additional setup after loading the view.

        fetchRewardsModelData(){(rewards,nil) in
            DispatchQueue.main.async {
                self.rewardsModelData = rewards
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchRewardsModelData(completionHandler completion: @escaping ([Reward]?, Error?) -> Void){
        // Prepare URL
        let url = URL(string:Constants.coreURL + "/rewards")
        guard let requestUrl = url else { fatalError() }
        var components = URLComponents(string: requestUrl.absoluteString)!
        components.queryItems = [
            URLQueryItem(name: "auth_token", value: UserModel.token),
            URLQueryItem(name: "appkey", value: Constants.appKey)
        ]
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

        // Prepare URL Request Object
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let rewardsModel = try? JSONDecoder().decode(RewardsModel.self, from: data!)
                    completion(rewardsModel?.rewards,nil)
                } else {
                    //handle error
                }
                
            }
        }
        task.resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return rewardsModelData!.count
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section != 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let topCell = tableView.dequeueReusableCell(withIdentifier: TopDashboardCell.identifier,for: indexPath) as? TopDashboardCell
            
            return topCell!
        }
        
       let cell = tableView.dequeueReusableCell(withIdentifier: BottomDashboardCell.identifier,for: indexPath) as? BottomDashboardCell
        cell?.titleLabel.text = rewardsModelData![indexPath.row].title
        cell?.detailLabel.text = rewardsModelData![indexPath.row].description
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellSeque" {
            let claimReawardController = segue.destination as! ClaimRewardController
            claimReawardController.reward = self.rewardsModelData![self.tableView.indexPathForSelectedRow!.row]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "cellSegue", sender: nil)
    }
}
