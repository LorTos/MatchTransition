//
//  MatchTransitionManager.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 11/10/2018.
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

enum TransitionDirection {
    case presenting
    case dismissing
}

protocol MatchTransitionDelegate: class {
    func setFinalStateForObjects(in view: UIView, direction: TransitionDirection)
}

public class MatchTransitionManager: NSObject {
    
    public override init() {
        super.init()
        presentTransition.delegate = self
        dismissTransition.delegate = self
    }

    //MARK: - Variables
    private let presentTransition = MatchTransitionPresentation()
    private let dismissTransition = MatchTransitionDismissal()
    private let objectManager = MatchTransitionObjectManager()
    
    private var matches: [Match] = []
    
    //MARK: - Initial setup
    public func setup(cell: UITableViewCell, to controller: UIViewController, with matches: [Match]) {
        self.matches = matches
        setupMatches(between: cell, and: controller, matches: matches)
    }
    public func setup(cell: UICollectionViewCell, to controller: UIViewController, with matches: [Match]) {
        self.matches = matches
        setupMatches(between: cell, and: controller, matches: matches)
    }
    
    //MARK: - Private funcs
    private func setupMatches(between cell: UITableViewCell, and controller: UIViewController, matches: [Match]) {
        if let navController = controller.navigationController {
            navController.delegate = self
        } else {
            controller.transitioningDelegate = self
        }
        
        objectManager.resetData()
        matches.forEach({
            objectManager.setTag($0.tag, for: $0.from)
            objectManager.setTag($0.tag, for: $0.to)
        })
        objectManager.transitioningTableCell(cell)
    }
    
    private func setupMatches(between cell: UICollectionViewCell, and controller: UIViewController, matches: [Match]) {
        if let navController = controller.navigationController {
            navController.delegate = self
        } else {
            controller.transitioningDelegate = self
        }
        
        objectManager.resetData()
        matches.forEach({
            objectManager.setTag($0.tag, for: $0.from)
            objectManager.setTag($0.tag, for: $0.to)
        })
        objectManager.transitioningCollectionCell(cell)
    }
}

//MARK: - MatchTransitionDelegate
extension MatchTransitionManager: MatchTransitionDelegate {
    func setFinalStateForObjects(in view: UIView, direction: TransitionDirection) {
        objectManager.setupFinalState(for: view) {
            switch direction {
            case .presenting:
                self.presentTransition.setTransitioningObjects(views: self.objectManager.views, imageViews: self.objectManager.imageViews, labels: self.objectManager.labels, buttons: self.objectManager.buttons)
            case .dismissing:
                self.dismissTransition.setTransitioningObjects(views: self.objectManager.views, imageViews: self.objectManager.imageViews, labels: self.objectManager.labels, buttons: self.objectManager.buttons)                
            }
        }
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension MatchTransitionManager: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
        
    }
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }
}

extension MatchTransitionManager: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return presentTransition
        case .pop:
            return dismissTransition
        default: return nil
        }
    }
}
