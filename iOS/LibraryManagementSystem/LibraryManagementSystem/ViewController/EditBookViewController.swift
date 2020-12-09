//
//  EditBookViewController.swift
//  LibraryManagementSystem
//
//  Created by Beehub on 08/12/20.
//

import UIKit
class EditBookViewController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var book = NSDictionary()
    var userId = Int()
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var bookNameTxt: UITextField!
    @IBOutlet weak var bookDetailsTxt: UITextField!
    @IBOutlet weak var authorNameTxt: UITextField!
    @IBOutlet weak var authorDetailsTxt: UITextField!
    @IBOutlet weak var authorAddressTxt: UITextField!
    @IBOutlet weak var publisherNameTxt: UITextField!
    @IBOutlet weak var publisherDateTxt: UITextField!
    @IBOutlet weak var publisherAddressTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoadData()
    }
    
    func initialLoadData() {
        print(book)
        bookNameTxt.text = book.object(forKey: "bookName") as? String ?? ""
        bookDetailsTxt.text = book.object(forKey: "bookDescription") as? String ?? ""
        authorNameTxt.text = (book.object(forKey: "author") as? NSDictionary ?? [:]).object(forKey: "authorName") as? String ?? ""
        authorDetailsTxt.text = (book.object(forKey: "author") as? NSDictionary ?? [:]).object(forKey: "authorDetails") as? String ?? ""
        authorAddressTxt.text = (book.object(forKey: "author") as? NSDictionary ?? [:]).object(forKey: "authorAddress") as? String ?? ""
        publisherNameTxt.text = (book.object(forKey: "publisher") as? NSDictionary ?? [:]).object(forKey: "publisherName") as? String ?? ""
        publisherDateTxt.text = (book.object(forKey: "publisher") as? NSDictionary ?? [:]).object(forKey: "publisherDate") as? String ?? ""
        publisherAddressTxt.text = (book.object(forKey: "publisher") as? NSDictionary ?? [:]).object(forKey: "publisherAddress") as? String ?? ""
    }
    
    @IBAction func tapToNavigateBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapToUploadImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        uploadImage.image = image
    }
    
    @IBAction func tapToUpdateBooks(_ sender: Any) {
        guard !(bookNameTxt.text?.isEmpty)! else {
            displayAlertMessage(message: "Book Name is empty",title: "Add Book")
            return
        }
        
        guard !(bookDetailsTxt.text?.isEmpty)! else {
            displayAlertMessage(message: "Book Details is empty",title: "Add Book")
            return
        }
        
        guard !(authorNameTxt.text?.isEmpty)! else {
            displayAlertMessage(message: "Auther Name is empty",title: "Edit Book")
            return
        }
        
        guard !(authorDetailsTxt.text?.isEmpty)! else {
            displayAlertMessage(message: "Auther Details is empty",title: "Edit Book")
            return
        }
        
        guard !(authorAddressTxt.text?.isEmpty)! else {
            displayAlertMessage(message: "Authoe Address is empty",title: "Edit Book")
            return
        }
        
        guard !(publisherNameTxt.text?.isEmpty)! else {
            displayAlertMessage(message: "Publisher Name is empty",title: "Edit Book")
            return
        }
        
        guard !(publisherDateTxt.text?.isEmpty)! else {
            displayAlertMessage(message: "Publisher Date is empty",title: "Edit Book")
            return
        }
        
        guard !(publisherAddressTxt.text?.isEmpty)! else {
            displayAlertMessage(message: "Publisher Address is empty",title: "Edit Book")
            return
        }
        
        UpdateBookData()
    }
    
    func displayAlertMessage(message:String,title:String) {
        self.present(UIAlertController.customAlert(title: title, message: message, cancelButtonTitle: "OK"), animated: true)
    }
    
    func UpdateBookData() {
        let parameterList = ["authorAddress":authorAddressTxt.text ?? "","authorDetails":authorDetailsTxt.text ?? "","authorName":authorNameTxt.text ?? "","bookDetails":bookDetailsTxt.text ?? "","bookImage":"","bookName":bookNameTxt.text ?? "","publisherAddress":publisherAddressTxt.text ?? "","publisherDate":publisherDateTxt.text ?? "","publisherName":publisherNameTxt.text ?? "","userId":userId,"bookId":book.object(forKey: "bookId") as? Int ?? 0] as dictionaryType
        let link = Network.PUT(endPoint: Endpoint.EditBookApi.rawValue, Parameter: parameterList)
        link.connect{ (response) in
            //ConstantTools.sharedConstantTool.startIndicator(view: self.view, action: "stop")
            switch response {
            case .success( _,let apiMesaage):
                print(apiMesaage)
                self.navigationController?.popViewController(animated: true)
            case .failure( _,let message):
                self.present(UIAlertController.customAlert(title: "Sign Up", message: message, cancelButtonTitle: "OK"), animated: true)
            }
        }
    }
}
