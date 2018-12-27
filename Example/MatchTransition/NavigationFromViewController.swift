//
//  NavigationFromViewController.swift
//  MatchTransition_Example
//
//  Created by Lorenzo Toscani De Col on 13/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class NavigationFromViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    
    private var transparentNavAppearance = NavConfig(tintColor: UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1),
                                                     barTintColor: nil,
                                                     shadowImage: UIImage(),
                                                     backgroundImage: UIImage(),
                                                     isTranslucent: true)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = UIImage(named: "Mountains")
        backgroundImageView.clipsToBounds = true
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
        
        navBar.tintColor = transparentNavAppearance.tintColor
        navBar.barTintColor = transparentNavAppearance.barTintColor
        navBar.shadowImage = transparentNavAppearance.shadowImage
        navBar.setBackgroundImage(transparentNavAppearance.backgroundImage, for: .default)
        navBar.isTranslucent = transparentNavAppearance.isTranslucent
    }
}

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
}
