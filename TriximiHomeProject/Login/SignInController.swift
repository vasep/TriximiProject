//
//  SignInController.swift
//  TriximiHomeProject
//
//  Created by Vasil Panov on 13.2.21.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class SignInController: UIViewController, LoginButtonDelegate {
    
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    let facebookLoginButton = FBLoginButton(frame: .zero, permissions: [.publicProfile])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookLoginButton.delegate = self
        facebookLoginButton.isHidden = true
        orLabel.font = UIFont(name: "Old Typography", size: 30)
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    @IBAction func signInAction(_ sender: Any) {
        checkAndDisplayError()
    }
    
    public func isValidPassword(_ password: String) -> Bool {
        //Password must be more than 6 characters, with at least one capital, numeric or special character
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        return passwordPred.evaluate(with: password)
    }
    
    func outlineErrorTxtField(field: UITextField){
        field.layer.borderWidth = 1.0
        field.layer.cornerRadius = 5
        field.layer.borderColor = UIColor.red.cgColor
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailPred.evaluate(with: email)
    }
    
    func checkAndDisplayError(){
        if(emailTxtField.text?.isEmpty ?? true ){
            emailTxtField.layer.borderWidth = 0
            outlineErrorTxtField(field: emailTxtField)
        } else if (passwordTxtField.text?.isEmpty ?? true ){
            passwordTxtField.layer.borderWidth = 0
            outlineErrorTxtField(field: passwordTxtField)
        } else if (!self.isValidEmail(emailTxtField.text!)){
            outlineErrorTxtField(field: emailTxtField)
        }else if(!self.isValidPassword(passwordTxtField.text!)){
            outlineErrorTxtField(field: passwordTxtField)
        }else {
            self.performLogin(passwordString: passwordTxtField.text!,usernameString: emailTxtField.text!)
        }
    }
    
    func performLogin(passwordString: String, usernameString: String){
        let json: [String: Any] = ["username": usernameString,
                                   "password":passwordString]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        // Prepare URL
        let url = URL(string: Constants.coreURL + "/user/signup")
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
                        UserModel.token = (response["token"] as! String?)!
                        UserDefaults.standard.set(UserModel.token, forKey: "token")
                        self.performSegue(withIdentifier: "signInSeque", sender: nil)
                    } else {
                        // signup/login unsuccessful
                    }
                } else {
                    //perform error action
                }
            }
        }).resume()
    }
    
    @IBAction func signUpWithFbAction(_ sender: Any) {
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
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }
                } else {
                    //perform error
                }
            }
        }).resume()
    }
}

