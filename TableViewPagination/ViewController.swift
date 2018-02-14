//
//  ViewController.swift
//  TableViewPagination
//
//  Created by Rajuabe on 13/09/17.
//  Copyright © 2017 Rajuabe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var randomArray = [Int]()
    var isDataLoading: Bool = false
    var pageNo:Int = 0
    var limit: Int = 20
    var offset: Int = 0
    var didEndReached:Bool = false
    var indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TableView Pagination"
        // Do any additional setup after loading the view, typically from a nib.
        self.addData()
    }
    @objc func addData(){
        for _ in 0..<10 {
            let randomNum = arc4random_uniform(100)
            self.randomArray.append(Int(randomNum))
        }
        if self.isDataLoading {
            self.indicator.stopAnimating()
        }
        self.tableView.reloadData()
    }
}

// MARK: - UITableView Delegate and DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "Namne :\(self.randomArray[indexPath.row])"
        return cell
    }
}

// MARK:  UIScrollview delegate methods
extension ViewController {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("Scrollview will begin dragging")
        isDataLoading = false
    }
    

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("Scrollview did end dragging")
        print("content offset :\(tableView.contentOffset.y) == height \(tableView.frame.size.height) == content height:\(tableView.contentSize.height)")
        if tableView.contentOffset.y.isLess(than: 0) {
            /*
             Adding pagination on top
             */
            // add here
        }
        else {
            if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height) {
                if !isDataLoading {
                    
                    isDataLoading = true
                    self.pageNo = self.pageNo + 1
                    self.limit = self.limit + 10
                    self.offset = self.limit * self.pageNo
                    //indicator.hidesWhenStopped = true
                    indicator.frame = CGRect(x: CGFloat(0), y: 0, width: tableView.bounds.width, height: 44)
                    
                    self.tableView.tableFooterView = indicator
                    indicator.startAnimating()
                    self.tableView.tableFooterView?.isHidden = false
                    //self.addData()
                    
                    _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.addData), userInfo: nil, repeats: false)
                    
                    
                }
            }
        }
        
        
    }
}


