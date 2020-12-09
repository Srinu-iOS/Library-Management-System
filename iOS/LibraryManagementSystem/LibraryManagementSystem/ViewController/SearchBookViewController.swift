//
//  SearchBookViewController.swift
//  LibraryManagementSystem
//
//  Created by Beehub on 08/12/20.
//

import UIKit

class SearchBookViewController: UIViewController {
    var search = String()
    var userId = Int()
    var booksData = NSArray()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoadData()
    }
    
    func initialLoadData() {
        loadBooksData()
    }
    
    func loadBooksData() {
        let link = Network.GET(endPoint: "\(Endpoint.SearchBooksApi.rawValue)\(search)=\(search)", Parameter: [:])
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
}

// MARK:- TableView Delegate & Datasource
extension SearchBookViewController : UITableViewDataSource, UITableViewDelegate {
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
