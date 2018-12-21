//
//  ExampleSelectionViewController.swift
//  MatchTransition_Example
//
//  Created by Lorenzo Toscani De Col on 12/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class ExampleSelectionViewController: UITableViewController {
    
    let tableModel = ["CollectionView", "NavigationController"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 64
        tableView.tableFooterView = UIView()
        
        navigationController?.navigationBar.tintColor = UIColor.black.withAlphaComponent(0.8)
        navigationItem.title = "Examples"
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleLabelCell", for: indexPath)
        cell.textLabel?.text = tableModel[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: performSegue(withIdentifier: "goToCollection", sender: nil)
        case 1: performSegue(withIdentifier: "goToNavigationExample", sender: nil)
        default: break
        }
    }
}
