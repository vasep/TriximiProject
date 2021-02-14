//
//  WelcomeController.swift
//  TriximiHomeProject
//
//  Created by Vasil Panov on 13.2.21.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class WelcomeController: UIViewController, LoginButtonDelegate{
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var returningUserLabel: UILabel!
    @IBOutlet weak var signUpFacebookBtn: UIButton!
    let facebookLoginButton = FBLoginButton(frame: .zero, permissions: [.publicProfile])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookLoginButton.delegate = self
        facebookLoginButton.isHidden = true
        welcomeLabel.font = UIFont(name: "Old Typography", size: 75)
        returningUserLabel.font = UIFont(name: "UnitedSansCond-Heavy", size: 25)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    @IBAction func signUpFacebookBtnAction(_ sender: Any) {
        facebookLoginButton.sendActions(for: .touchUpInside)
        
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"],from: self, handler: { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        })
    }
    
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result as Any)
                    
                    self.signUpServerCall(results: result as! [String: Any])
                }
            })
        }
    }
    
    func signUpServerCall(results : [String: Any]) {
                
        let json: [String: Any] = ["email": results,
                                   "register_type": 2,
                                   "appkey": Constants.appKey,
                                   "register_device_type": "iphone"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)

        // Prepare URL
        let url = URL(string: Constants.coreURL + "/user/signup")
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        // Set HTTP Request Body
        // Perform HTTP Request
        let _: Void = URLSession.shared.dataTask(with: request, completionHandler: {responseData, response, error in
            // Check for Error
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let responseJSON = try? JSONSerialization.jsonObject(with: responseData!, options:[])
                    if let response = responseJSON as? [String: Any] {
                        UserModel.token = (response["token"] as! String?)!
                        UserDefaults.standard.set(UserModel.token, forKey: "token")
                        self.performSegue(withIdentifier: "signInFBSeque", sender: nil)
                    }
                } else {
                    //perform error
                }
            }
        }).resume()
    }
}



