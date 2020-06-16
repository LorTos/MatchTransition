//
//  MatchTransitionObjectManager.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 11/10/2018.
//

import UIKit

class MatchTransitionObjectManager {
    enum TransitionType {
        case tableCell(UITableViewCell)
        case collectionCell(UICollectionViewCell)
        case viewController(UIViewController)
    }

    private var type: TransitionType!
    
    private(set) var tags: Set<Int> = []
    private(set) var objects: [TransitioningObject] = []
    var buttons: [MatchButton] {
        return objects.filter({ $0 is MatchButton }) as! [MatchButton]
    }
    var imageViews: [MatchImageView] {
        return objects.filter({ $0 is MatchImageView }) as! [MatchImageView]
    }
    var labels: [MatchLabel] {
        return objects.filter({ $0 is MatchLabel }) as! [MatchLabel]
    }
    var views: [MatchView] {
        return objects.filter({ $0 is MatchView }) as! [MatchView]
    }
    
    
    //MARK: - Set tags
    func setTag(_ tag: String, for view: UIView) {
        let hash = tag.hashValue
        
        tags.insert(hash)
        view.tag = hash
    }
    
    //MARK: - Creates transitioning objects
    func transitioning(_ transitionType: TransitionType) {
        type = transitionType
        findObjectForTags()
    }
    
    private func findObjectForTags() {
        tags.forEach { tag in
            switch type {
            case .tableCell(let cell)?:
                if let object = cell.viewWithTag(tag) {
                    createTransitioningObject(object)
                }
            case .collectionCell(let cell)?:
                if let object = cell.viewWithTag(tag) {
                    createTransitioningObject(object)
                }
            case .viewController(let controller)?:
                if let object = controller.view.viewWithTag(tag) {
                    createTransitioningObject(object)
                }
            default: break
            }
        }
    }
    private func createTransitioningObject(_ object: UIView, ignoresSafeArea: Bool = false) {
        func transitioningObject(_ object: UIView, baseView view: UIView) -> TransitioningObject {
            var convertedFrame = object.convert(object.bounds, to: view)
            var newObject: TransitioningObject
            switch object {
            case object as UIButton:
                let button = object as! UIButton
                newObject = MatchButton(button, id: button.tag, initialFrame: convertedFrame)
            case object as UILabel:
                let label = object as! UILabel
                newObject = MatchLabel(label, id: label.tag, initialFrame: convertedFrame)
            case object as UIImageView:
                let imageView = object as! UIImageView
                newObject = MatchImageView(imageView, id: imageView.tag, initialFrame: convertedFrame)
            default:
                let isBaseContainer = object === view || object.tag == "container".hashValue
                if isBaseContainer { convertedFrame = object.convert(object.bounds, to: UIScreen.main.coordinateSpace) }
                newObject = MatchView(object, id: object.tag, initialFrame: convertedFrame, isBaseContainer: isBaseContainer)
            }
            return newObject
        }
        
        var newObject: TransitioningObject
        switch type! {
        case .tableCell(let cell):
            newObject = transitioningObject(object, baseView: cell.contentView)
        case .collectionCell(let cell):
            newObject = transitioningObject(object, baseView: cell.contentView)
        case .viewController(let controller):
            newObject = transitioningObject(object, baseView: controller.view)
        }
        objects.append(newObject)
    }
    
    //MARK: - Set final state
    func setupFinalState(for view: UIView, completion: (() -> ())?) {
        view.layoutIfNeeded()
        
        tags.forEach { tag in
            guard   let transitioningObject = view.viewWithTag(tag),
                    let existingView = objects.first(where: { $0.nameId == tag }) else { return }
            
            let convertedFrame = transitioningObject.convert(transitioningObject.bounds, to: UIScreen.main.coordinateSpace)
            existingView.setFinalState(transitioningObject, finalFrame: convertedFrame)
        }
        
        completion!()
    }
    
    //MARK: - Reset
    func resetData() {
        tags = []
        objects = []
    }
}
