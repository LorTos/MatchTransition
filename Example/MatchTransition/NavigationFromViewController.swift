//
//  NavigationFromViewController.swift
//  MatchTransition_Example
//
//  Created by Lorenzo Toscani De Col on 13/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import MatchTransition

class NavigationFromViewController: UIViewController {
   
   @IBOutlet weak var backgroundImageView: UIImageView!
   @IBOutlet weak var loginButton: UIButton!
   @IBOutlet weak var facebookButton: UIButton!
   
   private lazy var manager: MatchTransitionManager = {
      let manager = MatchTransitionManager()
      navigationController?.delegate = manager
      return manager
   }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setupButtons()
      backgroundImageView.image = UIImage(named: "Mountains")
      backgroundImageView.contentMode = .scaleAspectFill
   }
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      setupNavigation()
   }
   
   private func setupButtons() {
      facebookButton.backgroundColor = UIColor(red: 58/255, green: 89/255, blue: 152/255, alpha: 1)
      loginButton.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
      [facebookButton, loginButton].forEach({ $0?.tintColor = .white })
      facebookButton.setTitle("Continue with Facebook", for: .normal)
      loginButton.setTitle("Login", for: .normal)
   }
   private func setupNavigation() {
      navigationItem.title = "Navigation Example"
      guard let navBar = navigationController?.navigationBar else { return }
      navBar.decorate(with: .transparent)
   }
   
   @IBAction func tappedOnButton(_ sender: UIButton) {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      if let destinationVC = storyboard.instantiateViewController(withIdentifier: "NavigationTo") as? NavigationToViewController {
         destinationVC.manager = manager
         let matches: [Match] = [
            Match(tag: "container", from: view, to: destinationVC.view),
            Match(tag: "backgroundImage", from: backgroundImageView, to: destinationVC.backgroundImageView),
            Match(tag: "facebook", from: facebookButton, to: destinationVC.facebookButton),
            Match(tag: "login", from: loginButton, to: destinationVC.loginButton)
         ]
         manager.setupTransition(from: self, to: destinationVC, with: matches, transitionType: .push)
         navigationController?.pushViewController(destinationVC, animated: true)
      }
   }
}
