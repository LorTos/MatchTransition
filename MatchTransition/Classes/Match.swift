//
//  Match.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 27/12/2018.
//

import UIKit

public struct Match {
    public var tag: String
    public var from: UIView
    public var to: UIView
    
    public init(tag: String, from: UIView, to: UIView) {
        self.tag = tag
        self.from = from
        self.to = to
    }
}
