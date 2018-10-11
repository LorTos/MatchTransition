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

public class MatchTransitionManager: NSObject {
    
    //MARK: - Singleton
    public static var shared = MatchTransitionManager()
    override private init() {
        super.init()
        transition.delegate = self
    }

    //MARK: - Variables
    private let transition = MatchTransition()
    private let objectManager = MatchTransitionObjectManager()
    
    private var matches: [Match] = []
    
    //MARK: - Initial setup
    public func setup(cell: UITableViewCell, to controller: UIViewController, with matches: [Match]) {
        self.matches = matches
        setupMatches(between: cell, and: controller, matches: matches)
    }
    public func setup(cell: UICollectionViewCell, at indexPath: IndexPath, inside collection: UICollectionView, to controller: UIViewController, with matches: [Match]) {
        self.matches = matches
        setupMatches(between: cell, at: indexPath, inside: collection, and: controller, matches: matches)
    }
    
    //MARK: - Private funcs
    private func setupMatches(between cell: UITableViewCell, and controller: UIViewController, matches: [Match]) {
        if controller.parent is UINavigationController {
            controller.parent!.transitioningDelegate = self
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
    
    private func setupMatches(between cell: UICollectionViewCell, at indexPath: IndexPath, inside collection: UICollectionView, and controller: UIViewController, matches: [Match]) {
        if controller.parent is UINavigationController {
            controller.parent!.transitioningDelegate = self
        } else {
            controller.transitioningDelegate = self
        }
        
        objectManager.resetData()
        matches.forEach({
            objectManager.setTag($0.tag, for: $0.from)
            objectManager.setTag($0.tag, for: $0.to)
        })
        objectManager.transitioningCollectionCell(cell, at: indexPath, in: collection)
    }
}

//MARK: - MatchTransitionDelegate
extension MatchTransitionManager: MatchTransitionDelegate {
    func setFinalState(forObjectsInView view: UIView) {
        objectManager.setupFinalState(for: view) {
            self.transition.setTransitioningObjects(views: self.objectManager.views, imageViews: self.objectManager.imageViews, labels: self.objectManager.labels, buttons: self.objectManager.buttons)
        }
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension MatchTransitionManager: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
