//
//  MatchImageView.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 21/08/2019.
//

import UIKit

class MatchImageView: UIImageView, TransitioningObject {
    var nameId: Int
    
    var initialFrame: CGRect
    var finalFrame: CGRect
    
    var isBaseContainer: Bool

    init(_ imageView: UIImageView, id: Int, initialFrame: CGRect) {
        nameId = id
        self.initialFrame = initialFrame
        finalFrame = initialFrame
        isBaseContainer = false
        
        super.init(frame: initialFrame)
        
        contentMode = imageView.contentMode
        image = imageView.image
        layer.cornerRadius = imageView.layer.cornerRadius
        layer.masksToBounds = imageView.layer.masksToBounds
        clipsToBounds = imageView.clipsToBounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFinalState(_ view: UIView, finalFrame: CGRect) {
        self.finalFrame = finalFrame
    }
}
