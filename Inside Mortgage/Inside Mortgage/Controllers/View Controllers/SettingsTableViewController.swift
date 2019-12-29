//
//  SettingsTableViewController.swift
//  Inside Mortgage
//
//  Created by Aaron Cleveland on 12/28/19.
//  Copyright © 2019 Aaron Cleveland. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    //MARK: -Variables
    var settingsLabel = [
        "Saved Loans",
        "About"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return settingsLabel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let savedLoanCell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
        savedLoanCell.nameLabel.text = settingsLabel[indexPath.row]
        return savedLoanCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "SavedLoansSegue", sender: indexPath)
        case 1:
            self.performSegue(withIdentifier: "AboutSegue", sender: indexPath)
        default:
            break
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }

}
