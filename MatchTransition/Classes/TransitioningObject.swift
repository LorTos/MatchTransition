//
//  TransitioningObject.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 21/08/2019.
//

import Foundation

@objc
protocol TransitioningObject {
    var nameId: Int { get set }
    var initialFrame: CGRect { get set }
    var finalFrame: CGRect { get set }
    
    var isBaseContainer: Bool { get set }
    
    @objc optional var initialCornerRadius: CGFloat { get set }
    @objc optional var finalCornerRadius: CGFloat { get set }
    @objc optional var initialBackgroundColor: UIColor? { get set }
    @objc optional var finalBackgroundColor: UIColor? { get set }
    @objc optional var initialFont: UIFont? { get set }
    @objc optional var finalFont: UIFont? { get set }
    @objc optional var initialTextColor: UIColor? { get set }
    @objc optional var finalTextColor: UIColor? { get set }
    
    func setFinalState(_ view: UIView, finalFrame: CGRect)
}
