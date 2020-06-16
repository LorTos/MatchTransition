//
//  MatchView.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 21/08/2019.
//

import UIKit

class MatchView: UIView, TransitioningObject {
    var nameId: Int
    
    var initialFrame: CGRect
    var finalFrame: CGRect
    
    var initialBackgroundColor: UIColor?
    var finalBackgroundColor: UIColor?
    
    var isBaseContainer: Bool
    
    init(_ view: UIView, id: Int, initialFrame: CGRect, isBaseContainer: Bool = false) {
        nameId = id
        self.initialFrame = initialFrame
        finalFrame = initialFrame
        self.isBaseContainer = isBaseContainer
        initialBackgroundColor = view.backgroundColor
        finalBackgroundColor = view.backgroundColor
        
        super.init(frame: initialFrame)
        
        layer.cornerRadius = view.layer.cornerRadius
        layer.masksToBounds = view.layer.masksToBounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFinalState(_ view: UIView, finalFrame: CGRect) {
        self.finalFrame = finalFrame
        finalBackgroundColor = view.backgroundColor
    }
}
