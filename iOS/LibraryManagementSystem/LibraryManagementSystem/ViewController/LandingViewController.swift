//
//  LandingViewController.swift
//  LibraryManagementSystem
//
//  Created by Beehub on 08/12/20.
//

import UIKit
import Charts

class LandingViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var toolBar: UITabBar!
    @IBOutlet weak var chartView: PieChartView!
    var userType = Int()
    var userId = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        toolBar.selectedItem = .none
    }
    
    func initialLoadData() {
        let months = ["No.of Books", "Stock", "lend", "Author", "Publisher", "Book Category"]
        let unitsSold = [20.0, 15.0, 5.0, 10.0, 12.0, 16.0]
        setChart(dataPoints: months, values: unitsSold)
        let decoded  = UserDefaults.standard.object(forKey: "userData") as! Data
        let userData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? NSDictionary ?? [:]
        userId = userData.object(forKey: "userId") as? Int ?? 0
        userType = userData.object(forKey: "userType") as? Int ?? 0
        let userName = userData.object(forKey: "name") as? String ?? ""
        nameLabel.text = "Hi \(userName)"
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        chartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [PieChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: Double(i))
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Books Data")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        chartView.data = pieChartData
        
        var colors: [UIColor] = []
                
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
                
        pieChartDataSet.colors = colors

    }
    
    func tapToLogout() {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        UserDefaults.standard.set("true", forKey: "isLogOut")
        UserDefaults.standard.removeObject(forKey: "userData")
        self.navigationController?.pushViewController(nextViewController, animated:true)
    }
}

// MARK:- TabBarDelegate
extension LandingViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item.tag == 0) {
            if userType == 1 {
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AdminBookVC") as! AdminBookViewController
                nextViewController.userId = userId
                self.navigationController?.pushViewController(nextViewController, animated:true)
            } else {
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UserBookVC") as! UserBookViewController
                nextViewController.userId = userId
                self.navigationController?.pushViewController(nextViewController, animated:true)
            }
        } else {
            let alert = UIAlertController(title: "", message: "Are you sure to Logout", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "Logout", style: UIAlertAction.Style.default, handler: { (UIAlertAction) -> Void in
                    self.tapToLogout()
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                    print("User click Dismiss button")
            }))
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
