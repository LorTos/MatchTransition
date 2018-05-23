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
    
    var finalFrame: CGRect!
    var finalFont: UIFont!
    var finalTextColor: UIColor!
    
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
