//
//  CardCollectionViewCell.swift
//  MatchTransition_Example
//
//  Created by Lorenzo Toscani De Col on 5/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
   
   @IBOutlet weak var backgroundImageView: UIImageView!
   @IBOutlet weak var mainTitleLabel: UILabel!
   @IBOutlet weak var pinImageView: UIImageView!
   @IBOutlet weak var locationLabel: UILabel!
   
   @IBOutlet weak var nextDateLabel: UILabel!
   @IBOutlet weak var monthLabel: UILabel!
   
   @IBOutlet weak var dateView1: UIView!
   @IBOutlet weak var dateLabel1: UILabel!
   @IBOutlet weak var dateView2: UIView!
   @IBOutlet weak var dateLabel2: UILabel!
   @IBOutlet weak var dateView3: UIView!
   @IBOutlet weak var dateLabel3: UILabel!
   
   private var imageOverlay: CALayer!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      backgroundColor = .clear
      [mainTitleLabel, locationLabel].forEach({ $0?.textColor = UIColor.white })
      
      [dateLabel1, dateLabel2, dateLabel3, monthLabel, nextDateLabel].forEach({ $0?.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1) })
      contentView.backgroundColor = UIColor.white
      autoresizesSubviews = true
   }
   
   func setup(with data: CardModel) {
      backgroundImageView.layer.masksToBounds = true
      backgroundImageView.image = data.image
      mainTitleLabel.text = data.title
      locationLabel.text = data.location.uppercased()
      monthLabel.text = data.month.uppercased()
      
      [dateLabel1, dateLabel2, dateLabel3].enumerated().forEach({ $0.element?.text = String(data.nextDates[$0.offset]) })
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      [dateView1, dateView2, dateView3].forEach { view in
         view?.layer.cornerRadius = 2
         view?.layer.masksToBounds = true
      }
      
      contentView.layer.cornerRadius = 4
      contentView.layer.masksToBounds = true
      
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOffset = CGSize(width: 0, height: 2)
      layer.shadowRadius = 6
      layer.shadowOpacity = 0.1
      layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 6).cgPath
      layer.masksToBounds = false
   }
}
