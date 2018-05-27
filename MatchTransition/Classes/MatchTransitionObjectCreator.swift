//
//  MatchTransitionObjectCreator.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 5/23/18.
//

class MatchTransitionObjectCreator {
    enum CellType {
        case tableCell
        case collectionCell
    }
    private var cellType: CellType!
    private(set) var tableCell: UITableViewCell?
    private(set) var baseCellAndCollection: ((UICollectionViewCell, IndexPath), UICollectionView)?
    
    private(set) var tags: [Int] = []
    
    private(set) var views: [TransitioningView] = []
    private(set) var imageViews: [TransitioningImageView] = []
    private(set) var labels: [TransitioningLabel] = []
    private(set) var buttons: [TransitioningButton] = []
    
    // Set cell tags and toVC tags first
    func setTag(_ tag: String, for view: UIView) {
        let hash = tag.hashValue
        
        if !tags.contains(hash) {
            tags.append(hash)
        }
        view.tag = hash
    }
    
    // Then pass the cell to the manager
    func transitioningTableCell(_ cell: UITableViewCell) {
        cellType = .tableCell
        tableCell = cell
        findObjectForTags()
    }
    func transitioningCollectionCell(_ cell: UICollectionViewCell, at indexPath: IndexPath, in collectionView: UICollectionView) {
        cellType = .collectionCell
        baseCellAndCollection = ((cell, indexPath), collectionView)
        findObjectForTags()
    }
    
    // Then pass toVC to the manager
    func arrivalViewController(_ viewController: UIViewController) {
        viewController.view.layoutIfNeeded()
        tags.forEach { tag in
            guard let transitioningObject = viewController.view.viewWithTag(tag) else { return }
            if let button = transitioningObject as? UIButton {
                if let existingButton = buttons.filter({ $0.nameID == tag }).first {
                    let convertedFrame = button.convert(button.bounds, to: UIScreen.main.coordinateSpace)
                    existingButton.finalFrame = convertedFrame
                    existingButton.finalTextFont = button.titleLabel?.font
                    existingButton.finalBackgroundColor = button.backgroundColor
                    existingButton.finalTextColor = button.titleColor(for: .normal)
                    existingButton.finalCornerRadius = button.layer.cornerRadius
                }
            } else if let label = transitioningObject as? UILabel {
                if let existingLabel = labels.filter({ $0.nameID == tag }).first {
                    let convertedFrame = label.convert(label.bounds, to: UIScreen.main.coordinateSpace)
                    existingLabel.finalFrame = convertedFrame
                    existingLabel.finalFont = label.font
                    existingLabel.finalTextColor = label.textColor
                }
            } else if let imageView = transitioningObject as? UIImageView {
                if let existingImageView = imageViews.filter({ $0.nameID == tag }).first {
                    let convertedFrame = imageView.convert(imageView.bounds, to: UIScreen.main.coordinateSpace)
                    existingImageView.finalFrame = convertedFrame
                    existingImageView.finalCornerRadius = imageView.layer.cornerRadius
                }
            } else {
                if let existingView = views.filter({ $0.nameID == tag }).first {
                    let convertedFrame = transitioningObject.convert(transitioningObject.bounds, to: UIScreen.main.coordinateSpace)
                    existingView.finalFrame = convertedFrame
                    existingView.finalBackgroundColor = transitioningObject.backgroundColor
                    existingView.finalCornerRadius = transitioningObject.layer.cornerRadius
                }
            }
        }
    }
    
    func resetData() {
        tags = []
        views = []
        imageViews = []
        labels = []
        buttons = []
    }
    
    private func findObjectForTags() {
        tags.forEach { tag in
            switch cellType {
            case .tableCell:
                if let object = tableCell!.viewWithTag(tag) {
                    createTransitioningObject(object, isInTableCell: true)
                }
            case .collectionCell:
                if let object = baseCellAndCollection!.0.0.viewWithTag(tag) {
                    createTransitioningObject(object, isInTableCell: false, collectionView: baseCellAndCollection!.1)
                }
            default: break
            }
        }
    }
    
    private func createTransitioningObject(_ object: UIView, isInTableCell: Bool, collectionView: UICollectionView? = nil) {
        if isInTableCell {
            if let button = object as? UIButton {
                let transitioningObject = TransitioningButton(with: button, id: button.tag, initialFrame: button.convert(button.bounds, to: tableCell!.contentView))
                buttons.append(transitioningObject)
            } else if let label = object as? UILabel {
                let transitioningObject = TransitioningLabel(with: label, id: label.tag, initialFrame: label.convert(label.bounds, to: tableCell!.contentView))
                labels.append(transitioningObject)
            } else if let imageView = object as? UIImageView {
                let transitioningObject = TransitioningImageView(with: imageView, id: imageView.tag, initialFrame: imageView.convert(imageView.bounds, to: tableCell!.contentView))
                imageViews.append(transitioningObject)
            } else {
                let isBaseContainer = object === tableCell!.contentView
                let transitioningObject = TransitioningView(with: object, id: object.tag, initialFrame: isBaseContainer ? object.convert(object.bounds, to: UIScreen.main.coordinateSpace) : object.convert(object.bounds, to: tableCell), isBaseContainer: isBaseContainer)
                views.append(transitioningObject)
            }
        } else {
            if let button = object as? UIButton {
                let transitioningObject = TransitioningButton(with: button, id: button.tag, initialFrame: button.convert(button.bounds, to: baseCellAndCollection!.0.0.contentView))
                buttons.append(transitioningObject)
            } else if let label = object as? UILabel {
                let transitioningObject = TransitioningLabel(with: label, id: label.tag, initialFrame: label.convert(label.bounds, to: baseCellAndCollection!.0.0.contentView))
                labels.append(transitioningObject)
            } else if let imageView = object as? UIImageView {
                let transitioningObject = TransitioningImageView(with: imageView, id: imageView.tag, initialFrame: imageView.convert(imageView.bounds, to: baseCellAndCollection!.0.0.contentView))
                imageViews.append(transitioningObject)
            } else {
                let isBaseContainer = object === (isInTableCell ? tableCell!.contentView : baseCellAndCollection!.0.0.contentView)
                if isBaseContainer {
                    let collection = baseCellAndCollection!.1
                    let layoutAttributes = collection.layoutAttributesForItem(at: baseCellAndCollection!.0.1)
                    let cellFrame = layoutAttributes!.frame
                    
                    let transitioningObject = TransitioningView(with: object, id: object.tag, initialFrame: collection.convert(cellFrame, to: UIScreen.main.coordinateSpace), isBaseContainer: true)
                    views.append(transitioningObject)
                } else {
                    let transitioningObject = TransitioningView(with: object, id: object.tag, initialFrame:  object.convert(object.bounds, to: baseCellAndCollection!.0.0), isBaseContainer: isBaseContainer)
                    views.append(transitioningObject)
                }
                
            }
        }
    }
}
