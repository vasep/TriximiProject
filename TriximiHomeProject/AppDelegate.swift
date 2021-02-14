//
//  AppDelegate.swift
//  TriximiHomeProject
//
//  Created by Vasil Panov on 12.2.21.
//

import UIKit
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window:UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        UserModel.token = UserDefaults.standard.string(forKey:"token") ?? ""
        
        let bypassLoginPage = true
        
        if (!UserModel.token.isEmpty || bypassLoginPage) {
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let initialViewController = storyboard.instantiateInitialViewController()
            self.window!.rootViewController = initialViewController
        } else {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let initialViewController = storyboard.instantiateInitialViewController()
            self.window!.rootViewController = initialViewController
        }
        self.window!.makeKeyAndVisible()
        
        let customFont = UIFont(name: "Old Typography", size: 24)!
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: customFont], for: .normal)
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        
    }
    
}
