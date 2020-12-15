//
//  TableViewController.swift
//  TableWithRefreshControl
//
//  Created by 加瀬悠人 on 2020/12/02.
//

import UIKit

class TableViewController: UITableViewController {
    
    let dateFormatter = DateFormatter()
    var dateArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "yyyy年/M月/d日/H時/m分/s秒/SSSミリ秒"
        let now = Date()
        dateArray = dateFormatter.string(from: now).components(separatedBy: "/")
        
        refreshControl?.addTarget(self, action:
                                        #selector(handleRefreshControl),
                                        for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
       // Update your content…
        let now = Date()
        dateArray = dateFormatter.string(from: now).components(separatedBy: "/")
        tableView.reloadData()

       // Dismiss the refresh control.
       DispatchQueue.main.async {
        self.refreshControl?.endRefreshing()
       }
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel!.text = dateArray[indexPath.row]
        return cell
    }
}
