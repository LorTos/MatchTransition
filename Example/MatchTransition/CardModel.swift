//
//  CardModel.swift
//  MatchTransition_Example
//
//  Created by Lorenzo Toscani De Col on 5/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class CardModel {
   
   var title: String!
   var image: UIImage!
   var location: String!
   
   var month: String!
   var nextDates: [Int]!
   
   init(image: UIImage, title: String, location: String, month: String, dates: [Int]) {
      self.title = title
      self.image = image
      self.location = location
      self.month = month
      nextDates = dates
   }
   
}
