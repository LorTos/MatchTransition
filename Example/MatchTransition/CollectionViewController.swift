//
//  CollectionViewController.swift
//  MatchTransition_Example
//
//  Created by Lorenzo Toscani De Col on 5/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CardCollectionViewCell"

class CollectionViewController: UICollectionViewController {

    let data: [CardModel] = [
        CardModel(image: #imageLiteral(resourceName: "Thailand"), title: "West Islands Boat Tour", location: "Thailand".uppercased(), month: "April".uppercased(), dates: [15, 19, 24]),
        CardModel(image: #imageLiteral(resourceName: "Positano"), title: "2-Day Positano City Tour", location: "Positano, Italy", month: "April".uppercased(), dates: [17, 19, 21]),
        CardModel(image: #imageLiteral(resourceName: "Bali"), title: "3-Day Surf Lessons", location: "Bali, Indonesia".uppercased(), month: "May", dates: [4, 9, 14]),
         CardModel(image: #imageLiteral(resourceName: "MonumentValley"), title: "Monument Valley Exploration", location: "Monument Valley, USA".uppercased(), month: "May", dates: [15, 22, 28])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView!.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCollectionViewCell
        cell.setup(with: data[indexPath.row])
        return cell
    }

}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideLength = UIScreen.main.bounds.width - 64
        return CGSize(width: sideLength, height: sideLength)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
}
