//
//  MatchButton.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 21/08/2019.
//

import UIKit

class MatchButton: UIButton, TransitioningObject {
    var nameId: Int
    
    var initialFrame: CGRect
    var finalFrame: CGRect
    
    var initialTextColor: UIColor?
    var finalTextColor: UIColor?
    
    var initialFont: UIFont?
    var finalFont: UIFont?
    
    var initialBackgroundColor: UIColor?
    var finalBackgroundColor: UIColor?
    
    var isBaseContainer: Bool
    
    init(_ button: UIButton, id: Int, initialFrame: CGRect) {
        nameId = id
        self.initialFrame = initialFrame
        finalFrame = initialFrame
        isBaseContainer = false
        initialTextColor = button.titleColor(for: .normal)
        finalTextColor = button.titleColor(for: .normal)
        initialFont = button.titleLabel?.font
        finalFont = button.titleLabel?.font
        initialBackgroundColor = button.backgroundColor
        finalBackgroundColor = button.backgroundColor
        
        super.init(frame: initialFrame)
        
        backgroundColor = initialBackgroundColor
        setTitle(button.title(for: .normal), for: .normal)
        setTitleColor(initialTextColor, for: .normal)
        titleLabel?.font = initialFont
        layer.cornerRadius = button.layer.cornerRadius
        layer.masksToBounds = button.layer.masksToBounds
        setImage(button.image(for: .normal), for: .normal)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFinalState(_ view: UIView, finalFrame: CGRect) {
        self.finalFrame = finalFrame
        finalBackgroundColor = view.backgroundColor
        
        guard let button = view as? UIButton else { return }
        
        finalTextColor = button.titleColor(for: .normal)
        finalFont = button.titleLabel?.font
    }
}
