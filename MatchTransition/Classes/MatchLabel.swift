//
//  MatchLabel.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 21/08/2019.
//

import UIKit

class MatchLabel: UILabel, TransitioningObject {
    var nameId: Int
    
    var initialFrame: CGRect
    var finalFrame: CGRect
    
    var initialFont: UIFont?
    var finalFont: UIFont?
    
    var initialTextColor: UIColor?
    var finalTextColor: UIColor?
    
    var isBaseContainer: Bool
    
    init(_ label: UILabel, id: Int, initialFrame: CGRect) {
        nameId = id
        self.initialFrame = initialFrame
        finalFrame = initialFrame
        initialFont = label.font
        finalFont = label.font
        initialTextColor = label.textColor
        finalTextColor = label.textColor
        isBaseContainer = false
        
        super.init(frame: initialFrame)
        
        text = label.text
        textColor = label.textColor
        font = label.font
        textAlignment = label.textAlignment
        numberOfLines = label.numberOfLines
        lineBreakMode = label.lineBreakMode
        backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setFinalState(_ view: UIView, finalFrame: CGRect) {
        self.finalFrame = finalFrame
        
        guard let label = view as? UILabel else { return }
        finalFont = label.font
        finalTextColor = label.textColor
    }
    

    

}
