//
//  SignUpViewController.swift
//  LibraryManagementSystem
//
//  Created by Beehub on 08/12/20.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var mobileTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapToNavigateBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapToSignUp(_ sender: Any) {
        validateTextField()
    }
    
    func validateTextField() {
        guard !(nameTxt.text?.isEmpty)! else {
            displayAlertMessage(message: "Full Name is empty",title: "Sign Up")
            return
        }
        
        guard !(emailTxt.text?.isEmpty)! else {
            displayAlertMessage(message: "Email Id is empty",title: "Sign Up")
            return
        }
        
        let checkEmail = ConstantTools.sharedConstantTool.isValidEmail(email: emailTxt.text!)
        if !checkEmail {
            displayAlertMessage(message: "Use vaild email only.",title: "Sign Up")
            return
        }
        
        guard !(mobileTxt.text?.isEmpty)! else {
            displayAlertMessage(message: "Mobile Number is empty",title: "Sign Up")
            return
        }
        
        let checkPhoneNumber = ConstantTools.sharedConstantTool.isValidMobileNumber(phoneNumber: mobileTxt.text!)
        if !checkPhoneNumber {
            displayAlertMessage(message: "Use valid Mobile Number",title: "Sign Up")
            return
        }
        
        guard !(passwordTxt.text?.isEmpty)! else {
            displayAlertMessage(message: "Password is empty",title: "Sign Up")
            return
        }
        
        guard !(confirmPasswordTxt.text?.isEmpty)! else {
            displayAlertMessage(message: "Confirm Password is empty",title: "Sign Up")
            return
        }
        
        if passwordTxt.text != confirmPasswordTxt.text {
            displayAlertMessage(message: "Password does not match",title: "Sign Up")
            return
        }
        signUpNewUser()
    }
    
    func signUpNewUser() {
        //ConstantTools.sharedConstantTool.startIndicator(view: self.view, action: "start")
        let parameterList = ["name":nameTxt.text ?? "","mobileNumber":mobileTxt.text ?? "","emailId":emailTxt.text ?? "","password":confirmPasswordTxt.text ?? ""] as dictionaryType
        let link = Network.POST(endPoint: Endpoint.SignUpApi.rawValue, Parameter: parameterList)
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
                self.present(UIAlertController.customAlert(title: "Sign Up", message: message, cancelButtonTitle: "OK"), animated: true)
            }
        }
    }
    
    func displayAlertMessage(message:String,title:String) {
        self.present(UIAlertController.customAlert(title: title, message: message, cancelButtonTitle: "OK"), animated: true)
    }
}
