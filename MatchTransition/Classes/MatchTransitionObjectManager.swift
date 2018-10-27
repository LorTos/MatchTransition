//
//  MatchTransitionObjectManager.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 11/10/2018.
//

import UIKit

class MatchTransitionObjectManager {
    enum CellType {
        case tableCell(UITableViewCell)
        case collectionCell(UICollectionViewCell)
    }
    private var cellType: CellType!
    
    private(set) var tags: [Int] = []
    
    private(set) var views: [TransitioningView] = []
    private(set) var imageViews: [TransitioningImageView] = []
    private(set) var labels: [TransitioningLabel] = []
    private(set) var buttons: [TransitioningButton] = []
    
    
    //MARK: - Set tags
    func setTag(_ tag: String, for view: UIView) {
        let hash = tag.hashValue
        
        if !tags.contains(hash) {
            tags.append(hash)
        }
        view.tag = hash
    }
    
    //MARK: - Creates transitioning objects
    func transitioningTableCell(_ cell: UITableViewCell) {
        cellType = .tableCell(cell)
        findObjectForTags()
    }
    func transitioningCollectionCell(_ cell: UICollectionViewCell) {
        cellType = .collectionCell(cell)
        findObjectForTags()
    }
    private func findObjectForTags() {
        tags.forEach { tag in
            switch cellType {
            case .tableCell(let cell)?:
                if let object = cell.viewWithTag(tag) {
                    createTransitioningObject(object)
                }
            case .collectionCell(let cell)?:
                if let object = cell.viewWithTag(tag) {
                    createTransitioningObject(object)
                }
            default: break
            }
        }
    }
    private func createTransitioningObject(_ object: UIView, ignoresSafeArea: Bool = false) {
        switch cellType {
        case .tableCell(let cell)?:
            var convertedFrame = object.convert(object.bounds, to: cell.contentView)
            if let button = object as? UIButton {
                let transitioningObject = TransitioningButton(with: button, id: button.tag, initialFrame: convertedFrame)
                buttons.append(transitioningObject)
            } else if let label = object as? UILabel {
                let transitioningObject = TransitioningLabel(with: label, id: label.tag, initialFrame: convertedFrame)
                labels.append(transitioningObject)
            } else if let imageView = object as? UIImageView {
                let transitioningObject = TransitioningImageView(with: imageView, id: imageView.tag, initialFrame: convertedFrame)
                imageViews.append(transitioningObject)
            } else {
                let isBaseContainer = object === cell.contentView
                if isBaseContainer {
                    convertedFrame = object.convert(object.bounds, to: UIScreen.main.coordinateSpace)
                }
                let transitioningObject = TransitioningView(with: object, id: object.tag, initialFrame: convertedFrame, isBaseContainer: isBaseContainer)
                views.append(transitioningObject)
            }
        case .collectionCell(let cell)?:
            var convertedFrame = object.convert(object.bounds, to: cell.contentView)
            if let button = object as? UIButton {
                let transitioningObject = TransitioningButton(with: button, id: button.tag, initialFrame: convertedFrame)
                buttons.append(transitioningObject)
            } else if let label = object as? UILabel {
                let transitioningObject = TransitioningLabel(with: label, id: label.tag, initialFrame: convertedFrame)
                labels.append(transitioningObject)
            } else if let imageView = object as? UIImageView {
                let transitioningObject = TransitioningImageView(with: imageView, id: imageView.tag, initialFrame: convertedFrame)
                imageViews.append(transitioningObject)
            } else {
                let isBaseContainer = object === cell.contentView
                if isBaseContainer {
                    convertedFrame = object.convert(object.bounds, to: UIScreen.main.coordinateSpace)
                }
                
                let transitioningObject = TransitioningView(with: object, id: object.tag, initialFrame: convertedFrame, isBaseContainer: isBaseContainer)
                views.append(transitioningObject)
            }
        default: break
        }
    }
    
    //MARK: - Set final state
    func setupFinalState(for view: UIView, completion: (() -> ())?) {
        view.layoutIfNeeded()
        
        tags.forEach { tag in
            guard let transitioningObject = view.viewWithTag(tag) else { return }
            let convertedFrame = transitioningObject.convert(transitioningObject.bounds, to: UIScreen.main.coordinateSpace)
            
            if let button = transitioningObject as? UIButton {
                if let existingButton = buttons.first(where: { $0.nameID == tag }) {
                    existingButton.setFinalState(to: button, finalFrame: convertedFrame)
                }
            } else if let label = transitioningObject as? UILabel {
                if let existingLabel = labels.first(where: { $0.nameID == tag }) {
                    existingLabel.setFinalState(to: label, finalFrame: convertedFrame)
                }
            } else if let imageView = transitioningObject as? UIImageView {
                if let existingImageView = imageViews.first(where: { $0.nameID == tag }) {
                    existingImageView.setFinalState(to: imageView, finalFrame: convertedFrame)
                }
            } else {
                if let existingView = views.first(where: { $0.nameID == tag }) {
                    existingView.setFinalState(to: transitioningObject, finalFrame: convertedFrame)
                }
            }
        }
        
        completion!()
    }
    
    //MARK: - Reset
    func resetData() {
        tags = []
        views = []
        imageViews = []
        labels = []
        buttons = []
    }
}
