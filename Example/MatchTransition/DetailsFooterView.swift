//
//  DetailsFooterView.swift
//  MatchTransition_Example
//
//  Created by Lorenzo Toscani De Col on 17/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class DetailsFooterView: UIView {
   
   @IBOutlet var view: UIView!
   @IBOutlet weak var nextDatesLabel: UILabel!
   @IBOutlet weak var monthLabel: UILabel!
   @IBOutlet weak var dateView1: UIView!
   @IBOutlet weak var dateView2: UIView!
   @IBOutlet weak var dateView3: UIView!
   @IBOutlet weak var dateLabel1: UILabel!
   @IBOutlet weak var dateLabel2: UILabel!
   @IBOutlet weak var dateLabel3: UILabel!
   @IBOutlet weak var button: UIButton!
   
   
   init() {
      super.init(frame: .zero)
      commonInit()
   }
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      commonInit()
   }
   
   private func commonInit() {
      Bundle.main.loadNibNamed("DetailsFooterView", owner: self, options: nil)
      view.frame = bounds
      addSubview(view)
      
      setupUI()
   }
   private func setupUI() {
      [dateLabel1, dateLabel2, dateLabel3, monthLabel, nextDatesLabel].forEach({
         $0?.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
      })
      
      [button, dateView1, dateView2, dateView3].forEach({
         $0?.layer.cornerRadius = 2
         $0?.layer.masksToBounds = true
      })
   }
   
   func setup(with card: CardModel) {
      monthLabel.text = card.month
      
      [dateLabel1, dateLabel2, dateLabel3].enumerated().forEach({ (index, label) in
         label?.text = String(describing: card.nextDates[index])
      })
   }
}
