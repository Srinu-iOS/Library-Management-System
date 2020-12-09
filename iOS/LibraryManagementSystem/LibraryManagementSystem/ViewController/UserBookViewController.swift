//
//  UserBookViewController.swift
//  LibraryManagementSystem
//
//  Created by Beehub on 08/12/20.
//

import UIKit

class UserBookViewController: UIViewController {
    @IBOutlet weak var noDataLable: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var booksData = NSArray()
    var userId = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialLoadData()
    }
    
    func initialLoadData() {
        noDataLable.isHidden = false
        tableView.isHidden = true
        loadLendBooks()
    }
    
    func loadLendBooks() {
        let link = Network.GET(endPoint: "\(Endpoint.UserLendBookListApi.rawValue)\(userId)", Parameter: [:])
        link.connect{ (response) in
            //ConstantTools.sharedConstantTool.startIndicator(view: self.view, action: "stop")
            switch response {
            case .success(let data,_):
                self.booksData = data as? NSArray ?? []
                if(self.booksData.count != 0) {
                    self.noDataLable.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
            case .failure( _,let message):
                self.present(UIAlertController.customAlert(title: "Books", message: message, cancelButtonTitle: "OK"), animated: true)
            }
        }
    }
    
    @IBAction func tapToNavigateBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapToSearchBooks(_ sender: Any) {
        let alertController = UIAlertController(title: "Search Books", message: "Select Category", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Author", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            self.navigateToNextPage(search:"author")
            }))
        alertController.addAction(UIAlertAction(title: "Book Name", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            self.navigateToNextPage(search:"bookName")
            }))
        alertController.addAction(UIAlertAction(title: "Publisher", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            self.navigateToNextPage(search:"publisher")
            }))
        alertController.addAction(UIAlertAction(title: "Book Category", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            self.navigateToNextPage(search:"bookCategory")
            }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func navigateToNextPage(search:String) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchBookVC") as! SearchBookViewController
        nextViewController.search = search
        nextViewController.userId = userId
        self.navigationController?.pushViewController(nextViewController, animated:true)
    }

}

// MARK:- TableView Delegate & Datasource
extension UserBookViewController : UITableViewDataSource, UITableViewDelegate {
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return booksData.count
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookListCell", for: indexPath) as! BookListTableViewCell
        let book = booksData[indexPath.section] as? NSDictionary ?? [:]
        cell.bookTitle.text = book["bookName"] as? String
        cell.bookDetail.text = book["bookDescription"] as? String
        cell.authorName.text = (book.object(forKey: "author") as? NSDictionary ?? [:]).object(forKey: "authorName") as? String ?? ""
        cell.publisherName.text = (book.object(forKey: "publisher") as? NSDictionary ?? [:]).object(forKey: "publisherName") as? String ?? ""
        return cell;
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = booksData[indexPath.section] as? NSDictionary ?? [:]
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BookDetailsVC") as! BookDetailsViewController
        nextViewController.book = book
        nextViewController.userId = userId
        self.navigationController?.pushViewController(nextViewController, animated:true)
    }
}
