//
//  MatchTransitionManager.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 11/10/2018.
//

import UIKit

protocol MatchTransitionDelegate: class {
    func setFinalStateForObjects(in view: UIView, direction: MatchTransitionManager.TransitionDirection)
}

public class MatchTransitionManager: NSObject {
    public enum NavigationType {
        case modal
        case push
    }
    public enum TransitionDirection {
        case presenting
        case dismissing
    }
    
    //MARK: - Variables
    private let presentTransition = MatchTransitionPresentation()
    private let dismissTransition = MatchTransitionDismissal()
    private let objectManager = MatchTransitionObjectManager()
    
    private var matches: [Match] = []
    
    
    //MARK: - Init
    public override init() {
        super.init()
        presentTransition.delegate = self
        dismissTransition.delegate = self
    }

    
    //MARK: - Initial setup
    public func setupTransition(from cell: UITableViewCell, inside initialController: UIViewController, to finalController: UIViewController, with matches: [Match], transitionType: NavigationType) {
        commonSetup(type: .tableCell(cell), navigationType: transitionType, initialController: initialController, finalController: finalController, matches: matches)
    }
    
    public func setupTransition(from cell: UICollectionViewCell, inside initialController: UIViewController, to finalController: UIViewController, with matches: [Match], transitionType: NavigationType) {
        commonSetup(type: .collectionCell(cell), navigationType: transitionType, initialController: initialController, finalController: finalController, matches: matches)
    }
    
    public func setupTransition(from initialController: UIViewController, to finalController: UIViewController, with matches: [Match], transitionType: NavigationType) {
        commonSetup(type: .viewController(initialController), navigationType: transitionType, initialController: initialController, finalController: finalController, matches: matches)
    }
    
    private func commonSetup(type: MatchTransitionObjectManager.TransitionType, navigationType: NavigationType, initialController: UIViewController, finalController: UIViewController, matches: [Match]) {
        setDelegate(for: navigationType, between: initialController, and: finalController)
        self.matches = matches
        setTags()
        objectManager.transitioning(type)
    }
    
    private func setDelegate(for transitionType: NavigationType, between initialController: UIViewController, and finalController: UIViewController) {
        switch transitionType {
        case .modal:
            finalController.modalPresentationStyle = .fullScreen
            finalController.transitioningDelegate = self
        case .push:
            return
        }
    }
    
    private func setTags() {
        objectManager.resetData()
        matches.forEach({
            objectManager.setTag($0.tag, for: $0.from)
            objectManager.setTag($0.tag, for: $0.to)
        })
    }
    
    public func transition(for direction: TransitionDirection) -> UIViewControllerAnimatedTransitioning {
        switch direction {
        case .presenting: return presentTransition
        case .dismissing: return dismissTransition
        }
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
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return presentTransition
        case .pop:
            return dismissTransition
        default: return nil
        }
    }
}
