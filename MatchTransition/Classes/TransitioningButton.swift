//
//  TransitioningButton.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 5/23/18.
//

import UIKit

class TransitioningButton: UIButton {
    private(set) var nameID: Int!
    private(set) var initialFrame: CGRect!
    private(set) var initialTextFont: UIFont!
    private(set) var initialTextColor: UIColor!
    private(set) var initialBackgroundColor: UIColor!
    private(set) var initialCornerRadius: CGFloat!
    
    private(set) var finalFrame: CGRect!
    private(set) var finalTextFont: UIFont!
    private(set) var finalTextColor: UIColor!
    private(set) var finalBackgroundColor: UIColor!
    private(set) var finalCornerRadius: CGFloat!
    
    var wantsCornerRadiusTransition: Bool {
        return initialCornerRadius != finalCornerRadius
    }
    
    init(with button: UIButton, id: Int, initialFrame: CGRect) {
        super.init(frame: initialFrame)
        nameID = id
        self.initialFrame = initialFrame
        setTitle(button.title(for: .normal), for: .normal)
        setTitleColor(button.titleColor(for: .normal), for: .normal)
        initialTextFont = button.titleLabel?.font
        initialTextColor = button.titleColor(for: .normal)
        initialBackgroundColor = button.backgroundColor
        initialCornerRadius = button.layer.cornerRadius
    }
    
    func setFinalState(to button: UIButton, finalFrame: CGRect) {
        self.finalFrame = finalFrame
        finalTextFont = button.titleLabel?.font
        finalBackgroundColor = button.backgroundColor
        finalTextColor = button.titleColor(for: .normal)
        finalCornerRadius = button.layer.cornerRadius
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
