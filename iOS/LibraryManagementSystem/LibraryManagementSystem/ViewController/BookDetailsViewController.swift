//
//  BookDetailsViewController.swift
//  LibraryManagementSystem
//
//  Created by Beehub on 08/12/20.
//

import UIKit

class BookDetailsViewController: UIViewController {
    var book = NSDictionary()
    var userId = Int()
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var bookCategory: UILabel!
    @IBOutlet weak var bookDetails: UILabel!
    @IBOutlet weak var lendBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoadData()
        let lendStatus = book.object(forKey: "lendStatus") as? Bool ?? false
        if(lendStatus) {
            lendBtn.setTitle("Return this Book", for: .normal)
        }
    }
    
    func initialLoadData() {
        bookName.text = "Book Name: \(book.object(forKey: "bookName") as? String ?? "")"
        bookDescription.text = book.object(forKey: "bookDescription") as? String ?? ""
        bookCategory.text = "Book Category: \(book.object(forKey: "bookCategory") as? String ?? "")"
        let publisherName = (book.object(forKey: "publisher") as? NSDictionary ?? [:]).object(forKey: "publisherName") as? String ?? ""
        let publisherDate = (book.object(forKey: "publisher") as? NSDictionary ?? [:]).object(forKey: "publisherDate") as? String ?? ""
        let publisherAddress = (book.object(forKey: "publisher") as? NSDictionary ?? [:]).object(forKey: "publisherAddress") as? String ?? ""
        
        let authorName = (book.object(forKey: "author") as? NSDictionary ?? [:]).object(forKey: "authorName") as? String ?? ""
        let authorDetails = (book.object(forKey: "author") as? NSDictionary ?? [:]).object(forKey: "authorDetails") as? String ?? ""
        let authorAddress = (book.object(forKey: "author") as? NSDictionary ?? [:]).object(forKey: "authorAddress") as? String ?? ""
        
        bookDetails.text = "Author Name: \(authorName)\n Author Details: \(authorDetails) \n Author Address: \(authorAddress) \n Publisher Name: \(publisherName) \n Publisher Date: \(publisherDate) \n Publisher Address: \(publisherAddress)"
    }
    
    func lendNewBook() {
        let parameterList = ["userId":userId,"bookId":book.object(forKey: "bookId") as? Int ?? 0] as dictionaryType
        let link = Network.PUT(endPoint: Endpoint.LendBookApi.rawValue, Parameter: parameterList)
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
    
    func returnLendBook() {
        let parameterList = ["userId":userId,"bookId":book.object(forKey: "bookId") as? Int ?? 0] as dictionaryType
        let link = Network.PUT(endPoint: Endpoint.ReturnLendBookApi.rawValue, Parameter: parameterList)
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
    
    @IBAction func tapToNavigateBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapLendBook(_ sender: Any) {
        let buttonText = lendBtn.title(for: .normal) ?? ""
        if buttonText == "Return this Book" {
            returnLendBook()
        } else {
          lendNewBook()
        }
    }
}
