//
//  Utility.swift
//  MatchTransition_Example
//
//  Created by Lorenzo Toscani De Col on 09/06/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

struct NavConfig {
   var tintColor: UIColor?
   var barTintColor: UIColor?
   var shadowImage: UIImage?
   var backgroundImage: UIImage?
   var isTranslucent: Bool
   
   init(navBar: UINavigationBar) {
      tintColor = navBar.tintColor
      barTintColor = navBar.barTintColor
      shadowImage = navBar.shadowImage
      backgroundImage = navBar.backgroundImage(for: .default)
      isTranslucent = navBar.isTranslucent
   }
   init(tintColor: UIColor?, barTintColor: UIColor?, shadowImage: UIImage?, backgroundImage: UIImage?, isTranslucent: Bool) {
      self.tintColor = tintColor
      self.barTintColor = barTintColor
      self.shadowImage = shadowImage
      self.backgroundImage = backgroundImage
      self.isTranslucent = isTranslucent
   }
   
   static var transparent: NavConfig {
      NavConfig(tintColor: UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1),
                barTintColor: nil,
                shadowImage: UIImage(),
                backgroundImage: UIImage(),
                isTranslucent: true)
   }
}

extension UINavigationBar {
   func decorate(with config: NavConfig) {
      tintColor = config.tintColor
      barTintColor = config.barTintColor
      shadowImage = config.shadowImage
      setBackgroundImage(config.backgroundImage, for: .default)
      isTranslucent = config.isTranslucent
   }
}
