//
//  TransitioningImageView.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 5/23/18.
//

import UIKit

class TransitioningImageView: UIImageView {
    private(set) var nameID: Int!
    private(set) var initialFrame: CGRect!
    private(set) var initialCornerRadius: CGFloat!
    
    var finalFrame: CGRect!
    var finalCornerRadius: CGFloat!
    
    init(with imageView: UIImageView, id: Int, initialFrame: CGRect) {
        super.init(frame: initialFrame)
        nameID = id
        self.initialFrame = initialFrame
        
        image = imageView.image
        
        contentMode = imageView.contentMode
        initialCornerRadius = imageView.layer.cornerRadius
        layer.cornerRadius = imageView.layer.cornerRadius
        layer.masksToBounds = imageView.layer.masksToBounds
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
