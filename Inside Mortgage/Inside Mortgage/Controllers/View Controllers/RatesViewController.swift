//
//  RatesViewController.swift
//  Inside Mortgage
//
//  Created by Aaron Cleveland on 1/8/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import UIKit

class RatesViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentDateLabel: UILabel!
    
    //MARK: - Variables
    let thirtyYear: [String] = [
        "Well’s Fargo: 3.750%",
        "Bank of America: 3.625%",
        "Quicken Loans: 3.875%",
        "Chase: 3.625%"
    ]
    
    let fifteenYear: [String] = [
        "Well’s Fargo: 2.875%",
        "Bank of America: 2.875%",
        "Quicken Loans: 3.375%",
        "Chase: 2.875%"
    ]
    
    let fiveOneArm: [String] = [
        "Well’s Fargo: 3.000%",
        "Bank of America: 2.875%",
        "Quicken Loans: 3.500%",
        "Chase: 2.625%"
    ]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter()
    }
    
    //MARK: - IBActions
    @IBAction func segmentedControlAction(_ sender: Any) {
        tableView.reloadData()
    }
    
    //MARK: - Helper Functions
    func dateFormatter() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        let timeString = dateFormatter.string(from: Date())
        currentDateLabel.text = String("Today's Rates: \(timeString)")
    }
}

extension RatesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            returnValue = thirtyYear.count
            break
        case 1:
            returnValue = fifteenYear.count
            break
        case 2:
            returnValue = fiveOneArm.count
            break
        default:
            break
        }
        
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            myCell.textLabel!.text = thirtyYear[indexPath.row]
            break
        case 1:
            myCell.textLabel!.text = fifteenYear[indexPath.row]
            break
        case 2:
            myCell.textLabel!.text = fiveOneArm[indexPath.row]
            break
        default:
            break
        }
        
        return myCell
    }
}
