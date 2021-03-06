//
//  NavigationToViewController.swift
//  MatchTransition_Example
//
//  Created by Lorenzo Toscani De Col on 27/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import MatchTransition

class NavigationToViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    var manager: MatchTransitionManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Navigation Example"
        backgroundImageView.image = UIImage(named: "Mountains")
        backgroundImageView.contentMode = .scaleAspectFill
        setupButtons()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
    }
    
    private func setupButtons() {
        facebookButton.backgroundColor = UIColor(red: 58/255, green: 89/255, blue: 152/255, alpha: 1)
        facebookButton.setTitle("Continue with Facebook", for: .normal)
        [facebookButton, loginButton, signupButton].forEach({ $0?.tintColor = .white })
        loginButton.setTitle("Login", for: .normal)
        signupButton.setTitle("Signup", for: .normal)
        loginButton.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        signupButton.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
}

extension NavigationToViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension NavigationToViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            return manager?.transition(for: .dismissing)
        }
        navigationController.delegate = nil
        return nil
    }
}
