//
//  TransitioningLabel.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 5/23/18.
//

import UIKit

class TransitioningLabel: UILabel {
    private(set) var nameID: Int!
    private(set) var initialFrame: CGRect!
    private(set) var initialFont: UIFont!
    private(set) var initialTextColor: UIColor!
    
    private(set) var finalFrame: CGRect!
    private(set) var finalFont: UIFont!
    private(set) var finalTextColor: UIColor!
    
    init(with label: UILabel, id: Int, initialFrame: CGRect) {
        super.init(frame: initialFrame)
        nameID = id
        self.initialFrame = initialFrame
        
        initialFont = label.font
        initialTextColor = label.textColor
        text = label.text
        
        textAlignment = label.textAlignment
        numberOfLines = label.numberOfLines
        backgroundColor = UIColor.clear
    }
    
    func setFinalState(to label: UILabel, finalFrame: CGRect) {
        self.finalFrame = finalFrame
        finalFont = label.font
        finalTextColor = label.textColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
