//
//  LoginViewController.swift
//  LibraryManagementSystem
//
//  Created by Beehub on 07/12/20.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailIdTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoadData()
    }
    
    func initialLoadData() {
        print("user data")
    }
    
    // MARK:- Button Action
    @IBAction func tapToSignIn(_ sender: Any) {
        guard !(emailIdTxt.text?.isEmpty)! else {
            displayAlertMessage(message: "Email Id is empty",title: "Sign In")
            return
        }
        
        let checkEmail = ConstantTools.sharedConstantTool.isValidEmail(email: emailIdTxt.text!)
        if !checkEmail {
            displayAlertMessage(message: "Use vaild email only.",title: "Sign In")
            return
        }
        
        guard !(passwordTxt.text?.isEmpty)! else {
            displayAlertMessage(message: "Password is empty",title: "Sign In")
            return
        }
        
        //ConstantTools.sharedConstantTool.startIndicator(view: self.view, action: "start")
        doLogin()
    }
    
    @IBAction func tapToSignUp(_ sender: Any) {
        let signupViewController = storyBoard.instantiateViewController(withIdentifier: "signUpVC") as! SignUpViewController
        self.navigationController?.pushViewController(signupViewController, animated:true)
    }
    
    func displayAlertMessage(message:String,title:String) {
        self.present(UIAlertController.customAlert(title: title, message: message, cancelButtonTitle: "OK"), animated: true)
    }
    
    func doLogin() {
        let parameterList = ["userName":emailIdTxt.text ?? "","password":passwordTxt.text ?? ""] as dictionaryType
        let link = Network.POST(endPoint: Endpoint.LoginApi.rawValue, Parameter: parameterList)
        link.connect{ (response) in
            //ConstantTools.sharedConstantTool.startIndicator(view: self.view, action: "stop")
            switch response {
            case .success(let data,_):
                let userData = data as! NSDictionary
                UserDefaults.standard.set("false", forKey: "isLogOut")
                do {
                    let encodedData = try NSKeyedArchiver.archivedData(withRootObject: userData, requiringSecureCoding: false)
                    UserDefaults.standard.set(encodedData, forKey: "userData")
                } catch {
                    print(error)
                }
                UserDefaults.standard.synchronize()
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "landingVC") as! LandingViewController
                self.navigationController?.pushViewController(nextViewController, animated:true)
            case .failure( _,let message):
                self.displayAlertMessage(message: message, title: "Sign In")
            }
        }
    }
}

// MARK:- TextFieldDelegates
extension LoginViewController:UITextFieldDelegate {
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
