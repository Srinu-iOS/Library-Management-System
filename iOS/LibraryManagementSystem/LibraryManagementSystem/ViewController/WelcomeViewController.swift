//
//  WelcomeViewController.swift
//  LibraryManagementSystem
//
//  Created by Beehub on 08/12/20.
//

import UIKit

class WelcomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isLogOut:String = UserDefaults.standard.string(forKey: "isLogOut") ?? "true"
        if isLogOut == "true" {
            let loginViewController = storyBoard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
            self.navigationController?.pushViewController(loginViewController, animated:true)
        } else {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "landingVC") as! LandingViewController
            self.navigationController?.pushViewController(nextViewController, animated:true)
        }
    }
}
