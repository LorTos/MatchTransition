//
//  DetailsHeaderView.swift
//  MatchTransition_Example
//
//  Created by Lorenzo Toscani De Col on 17/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

protocol DetailsHeaderViewDelegate: class {
    func tappedOnCancel()
}

class DetailsHeaderView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationIcon: UIImageView!
    
    weak var delegate: DetailsHeaderViewDelegate?
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 3/4))
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("DetailsHeaderView", owner: self, options: nil)
        view.frame = bounds
        addSubview(view)
        
        setupUI()
    }
    
    private func setupUI() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        
        titleLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        locationLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        [titleLabel, locationLabel].forEach({ $0?.textColor = UIColor.white })
        
        cancelButton.tintColor = UIColor.lightText
    }
    
    func setup(with card: CardModel) {
        backgroundImageView.image = card.image
        titleLabel.text = card.title
        locationLabel.text = card.location.uppercased()
    }
    
    @IBAction func tappedOnCancel(_ sender: UIButton) {
        delegate?.tappedOnCancel()
    }
}
