//
//  StateDetailTableViewController.swift
//  Representative
//
//  Created by Nathan Andrus on 2/7/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import UIKit

class StateDetailTableViewController: UITableViewController {

    var state: String?
    
    var representatives: [Representative] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        self.title = state
        guard let state = state else { return }
        RepresentativeController.searchRepresentatives(forState: state) { (representatives) in
            self.representatives = representatives
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return representatives.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "representativeCell", for: indexPath) as? RepTableViewCell
        
        let representative = representatives[indexPath.row]
        cell?.representativeLanding = representative
        return cell ?? UITableViewCell()
    }
}
