//
//  MatchTransitionConfigurator.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 5/23/18.
//

import UIKit

public struct Match {
    public var tag: String
    public var from: UIView
    public var to: UIView
}

public class MatchTransitionConfigurator: NSObject, UIViewControllerTransitioningDelegate {
    
    private let transition = MatchTransition()
    private let objectCreator = ObjectCreator()
    
    private static var match: MatchTransitionConfigurator!
    private var matches: [Match] = []
    
    public static func create(from cell: UITableViewCell, to controller: UIViewController, matching matches: [Match]) {
        match = MatchTransitionConfigurator()
        match.matches = matches
        match.setupMatch(between: cell, and: controller)
    }
    public static func create(from cell: UICollectionViewCell, at indexPath: IndexPath, inside collection: UICollectionView, to controller: UIViewController, matching matches: [Match]) {
        match = MatchTransitionConfigurator()
        match.matches = matches
        match.setupMatch(between: cell, at: indexPath, inside: collection, and: controller)
    }
    
    private func setupMatch(between cell: UITableViewCell, and controller: UIViewController) {
        if controller.parent is UINavigationController {
            controller.parent!.transitioningDelegate = self
        } else {
            controller.transitioningDelegate = self
        }
        
        objectCreator.resetData()
        matches.forEach { match in
            objectCreator.setTag(match.tag, for: match.from)
            objectCreator.setTag(match.tag, for: match.to)
        }
        objectCreator.transitioningTableCell(cell)
        objectCreator.arrivalViewController(controller)
    }
    private func setupMatch(between cell: UICollectionViewCell, at indexPath: IndexPath, inside collection: UICollectionView, and controller: UIViewController) {
        if controller.parent is UINavigationController {
            controller.parent!.transitioningDelegate = self
        } else {
            controller.transitioningDelegate = self
        }
        
        objectCreator.resetData()
        matches.forEach { match in
            objectCreator.setTag(match.tag, for: match.from)
            objectCreator.setTag(match.tag, for: match.to)
        }
        objectCreator.transitioningCollectionCell(cell, at: indexPath, in: collection)
        objectCreator.arrivalViewController(controller)
    }
    
    private func passMatchObjectsToTransition() {
        transition.setTransitioningObjects(views: objectCreator.views, imageViews: objectCreator.imageViews, labels: objectCreator.labels, buttons: objectCreator.buttons)
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        passMatchObjectsToTransition()
        return transition
    }
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}

