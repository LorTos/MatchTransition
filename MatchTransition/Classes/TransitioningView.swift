//
//  TransitioningView.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 5/23/18.
//

import UIKit

class TransitioningView: UIView {
    private(set) var nameID: Int!
    private(set) var initialFrame: CGRect!
    private(set) var initialBackgroundColor: UIColor!
    private(set) var initialCornerRadius: CGFloat!
    
    private(set) var finalFrame: CGRect!
    private(set) var finalBackgroundColor: UIColor!
    private(set) var finalCornerRadius: CGFloat!
    
    private(set) var isBaseContainer: Bool!
    
    var wantsCornerRadiusTransition: Bool {
        return initialCornerRadius != finalCornerRadius
    }
    
    init(with view: UIView, id: Int, initialFrame: CGRect, isBaseContainer: Bool = false) {
        super.init(frame: initialFrame)
        nameID = id
        self.initialFrame = initialFrame
        self.isBaseContainer = isBaseContainer
        
        initialBackgroundColor = view.backgroundColor
        backgroundColor = view.backgroundColor
        
        initialCornerRadius = view.layer.cornerRadius
        layer.cornerRadius = view.layer.cornerRadius
        layer.masksToBounds = view.layer.masksToBounds
    }
    
    func setFinalState(to view: UIView, finalFrame: CGRect) {
        self.finalFrame = finalFrame
        finalBackgroundColor = view.backgroundColor
        finalCornerRadius = view.layer.cornerRadius
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
