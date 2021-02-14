//
//  TriximilNavigationControllerViewController.swift
//  TriximiHomeProject
//
//  Created by Vasil Panov on 13.2.21.
//

import UIKit

class AppNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "header")
        
        self.navigationBar.setBackgroundImage(image?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0 ,right: 0), resizingMode: .stretch), for: .default)

        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.backgroundColor = .clear
        self.navigationBar.tintColor = .white
        
        self.navigationBar.barStyle = .black
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : UIFont(name: "Old Typography", size: 24) as Any,
            NSAttributedString.Key.foregroundColor : UIColor.white as Any]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
