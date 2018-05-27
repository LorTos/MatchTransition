//
//  DetailsViewController.swift
//  MatchTransition_Example
//
//  Created by Lorenzo Toscani De Col on 5/27/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var selectedCard: CardModel!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var pinImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var paragraphLabel: UILabel!
    @IBOutlet weak var nextDateLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var dateView1: UIView!
    @IBOutlet weak var dateView2: UIView!
    @IBOutlet weak var dateView3: UIView!
    
    @IBOutlet weak var dateLabel1: UILabel!
    @IBOutlet weak var dateLabel2: UILabel!
    @IBOutlet weak var dateLabel3: UILabel!
    
    @IBOutlet weak var bottomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        [paragraphLabel, nextDateLabel, monthLabel, dateLabel1, dateLabel2, dateLabel3].forEach({ $0?.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1) })
        
        [dateView1, dateView2, dateView3, bottomButton].forEach { view in
            view?.layer.cornerRadius = 6
            view?.layer.masksToBounds = true
        }
        
        setup(with: selectedCard)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    private func setup(with data: CardModel) {
        backgroundImageView.image = data.image
        locationTitleLabel.text = data.title
        locationLabel.text = data.location.uppercased()
        monthLabel.text = data.month.uppercased()
        
        [dateLabel1, dateLabel2, dateLabel3].enumerated().forEach({ $0.element?.text = String(data.nextDates[$0.offset]) })
    }
    
    @IBAction func dismissController(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
