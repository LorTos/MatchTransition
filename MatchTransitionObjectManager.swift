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
        case collectionCell(UICollectionViewCell, IndexPath, UICollectionView)
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
    func transitioningCollectionCell(_ cell: UICollectionViewCell, at indexPath: IndexPath, in collectionView: UICollectionView) {
        cellType = .collectionCell(cell, indexPath, collectionView)
        findObjectForTags()
    }
    private func findObjectForTags() {
        tags.forEach { tag in
            switch cellType {
            case .tableCell(let cell)?:
                if let object = cell.viewWithTag(tag) {
                    createTransitioningObject(object)
                }
            case .collectionCell(let cell, _, _)?:
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
            if let button = object as? UIButton {
                let transitioningObject = TransitioningButton(with: button, id: button.tag, initialFrame: button.convert(button.bounds, to: cell.contentView))
                buttons.append(transitioningObject)
            } else if let label = object as? UILabel {
                let transitioningObject = TransitioningLabel(with: label, id: label.tag, initialFrame: label.convert(label.bounds, to: cell.contentView))
                labels.append(transitioningObject)
            } else if let imageView = object as? UIImageView {
                let transitioningObject = TransitioningImageView(with: imageView, id: imageView.tag, initialFrame: imageView.convert(imageView.bounds, to: cell.contentView))
                imageViews.append(transitioningObject)
            } else {
                let isBaseContainer = object === cell.contentView
                let transitioningObject = TransitioningView(with: object, id: object.tag, initialFrame: isBaseContainer ? object.convert(object.bounds, to: UIScreen.main.coordinateSpace) : object.convert(object.bounds, to: cell), isBaseContainer: isBaseContainer)
                views.append(transitioningObject)
            }
        case .collectionCell(let cell, let indexPath, let collection)?:
            if let button = object as? UIButton {
                let transitioningObject = TransitioningButton(with: button, id: button.tag, initialFrame: button.convert(button.bounds, to: cell.contentView))
                buttons.append(transitioningObject)
            } else if let label = object as? UILabel {
                let transitioningObject = TransitioningLabel(with: label, id: label.tag, initialFrame: label.convert(label.bounds, to: cell.contentView))
                labels.append(transitioningObject)
            } else if let imageView = object as? UIImageView {
                let transitioningObject = TransitioningImageView(with: imageView, id: imageView.tag, initialFrame: imageView.convert(imageView.bounds, to: cell.contentView))
                imageViews.append(transitioningObject)
            } else {
                let isBaseContainer = object === cell.contentView
                if isBaseContainer {
                    let collection = collection
                    let layoutAttributes = collection.layoutAttributesForItem(at: indexPath)
                    let cellFrame = layoutAttributes!.frame
                    
                    let transitioningObject = TransitioningView(with: object, id: object.tag, initialFrame: collection.convert(cellFrame, to: UIScreen.main.coordinateSpace), isBaseContainer: true)
                    views.append(transitioningObject)
                } else {
                    let transitioningObject = TransitioningView(with: object, id: object.tag, initialFrame:  object.convert(object.bounds, to: cell.contentView), isBaseContainer: isBaseContainer)
                    views.append(transitioningObject)
                }
                
            }
        default: break
        }
    }
    
    //MARK: - Set final state
    func setupFinalState(for view: UIView, completion: (() -> ())?) {
        view.layoutIfNeeded()
        tags.forEach { tag in
            guard let transitioningObject = view.viewWithTag(tag) else { return }
            if let button = transitioningObject as? UIButton {
                if let existingButton = buttons.first(where: { $0.nameID == tag }) {
                    let convertedFrame = button.convert(button.bounds, to: UIScreen.main.coordinateSpace)
                    existingButton.finalFrame = convertedFrame
                    existingButton.finalTextFont = button.titleLabel?.font
                    existingButton.finalBackgroundColor = button.backgroundColor
                    existingButton.finalTextColor = button.titleColor(for: .normal)
                    existingButton.finalCornerRadius = button.layer.cornerRadius
                }
            } else if let label = transitioningObject as? UILabel {
                if let existingLabel = labels.first(where: { $0.nameID == tag }) {
                    let convertedFrame = label.convert(label.bounds, to: UIScreen.main.coordinateSpace)
                    existingLabel.finalFrame = convertedFrame
                    existingLabel.finalFont = label.font
                    existingLabel.finalTextColor = label.textColor
                }
            } else if let imageView = transitioningObject as? UIImageView {
                if let existingImageView = imageViews.first(where: { $0.nameID == tag }) {
                    let convertedFrame = imageView.convert(imageView.bounds, to: UIScreen.main.coordinateSpace)
                    existingImageView.finalFrame = convertedFrame
                    existingImageView.finalCornerRadius = imageView.layer.cornerRadius
                }
            } else {
                if let existingView = views.first(where: { $0.nameID == tag }) {
                    let convertedFrame = transitioningObject.convert(transitioningObject.bounds, to: UIScreen.main.coordinateSpace)
                    existingView.finalFrame = convertedFrame
                    existingView.finalBackgroundColor = transitioningObject.backgroundColor
                    existingView.finalCornerRadius = transitioningObject.layer.cornerRadius
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
