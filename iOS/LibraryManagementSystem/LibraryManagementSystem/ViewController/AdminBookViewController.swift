//
//  AdminBookViewController.swift
//  LibraryManagementSystem
//
//  Created by Beehub on 08/12/20.
//

import UIKit

class AdminBookViewController: UIViewController {
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
        loadBooksList()
    }
    
    func loadBooksList() {
        let link = Network.GET(endPoint: "\(Endpoint.AdmiBookListApi.rawValue)\(userId)", Parameter: [:])
        link.connect{ (response) in
            //ConstantTools.sharedConstantTool.startIndicator(view: self.view, action: "stop")
            switch response {
            case .success(let data,_):
                self.booksData = data as? NSArray ?? []
                self.tableView.reloadData()
            case .failure( _,let message):
                self.present(UIAlertController.customAlert(title: "Books", message: message, cancelButtonTitle: "OK"), animated: true)
            }
        }
    }
    
    @IBAction func tapToNavigateBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapToAddBooks(_ sender: Any) {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ManageBooksVC") as! ManageBooksViewController
        nextViewController.userId = userId
        self.navigationController?.pushViewController(nextViewController, animated:true)
    }
}

// MARK:- TableView Delegate & Datasource
extension AdminBookViewController : UITableViewDataSource, UITableViewDelegate {
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
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EditBookVC") as! EditBookViewController
        nextViewController.book = book
        nextViewController.userId = userId
        self.navigationController?.pushViewController(nextViewController, animated:true)
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

// MARK:- ContractDetaisTableViewCell
class BookListTableViewCell: UITableViewCell {
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookDetail: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var publisherName: UILabel!
}
