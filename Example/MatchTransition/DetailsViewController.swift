//
//  DetailsViewController.swift
//  MatchTransition_Example
//
//  Created by Lorenzo Toscani De Col on 17/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var cardModel: CardModel!
    private(set) var header: DetailsHeaderView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerView: DetailsFooterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        setupHeader()
        footerView.setup(with: cardModel)
    }
    
    private func setupHeader() {
        header = DetailsHeaderView()
        header.setup(with: cardModel)
        header.delegate = self
        tableView.tableHeaderView = header
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

extension DetailsViewController: DetailsHeaderViewDelegate {
    func tappedOnCancel() {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
