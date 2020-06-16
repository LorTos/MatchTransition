//
//  CollectionViewController.swift
//  MatchTransition_Example
//
//  Created by Lorenzo Toscani De Col on 5/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import MatchTransition

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
   
   private let reuseIdentifier = "CardCollectionViewCell"
   
   let data: [CardModel] = [
      CardModel(image: #imageLiteral(resourceName: "Thailand"), title: "West Islands Boat Tour", location: "Thailand".uppercased(), month: "April".uppercased(), dates: [15, 19, 24]),
      CardModel(image: #imageLiteral(resourceName: "Positano"), title: "2-Day Positano City Tour", location: "Positano, Italy", month: "April".uppercased(), dates: [17, 19, 21]),
      CardModel(image: #imageLiteral(resourceName: "Bali"), title: "3-Day Surf Lessons", location: "Bali, Indonesia".uppercased(), month: "May", dates: [4, 9, 14]),
      CardModel(image: #imageLiteral(resourceName: "MonumentValley"), title: "Monument Valley Exploration", location: "Monument Valley, USA".uppercased(), month: "May", dates: [15, 22, 28])
   ]
   
   let manager = MatchTransitionManager()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      navigationItem.title = "CollectionView"
      collectionView!.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
      collectionView!.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)
   }
   
   // MARK: - CollectionView Delegate
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return data.count
   }
   
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCollectionViewCell
      cell.setup(with: data[indexPath.row])
      return cell
   }
   
   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      presentDetailsForCard(at: indexPath)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let sideLength = UIScreen.main.bounds.width - 64
      return CGSize(width: sideLength, height: sideLength)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 24
   }
   
   // MARK: - Present Card Details
   private func presentDetailsForCard(at indexPath: IndexPath) {
      let selectedLocation = data[indexPath.row]
      let selectedCell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
      
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
      detailsViewController.cardModel = selectedLocation
      
      let matches = [
         Match(tag: "container", from: selectedCell.contentView, to: detailsViewController.view),
         Match(tag: "imageView", from: selectedCell.backgroundImageView, to: detailsViewController.header.backgroundImageView),
         Match(tag: "title", from: selectedCell.mainTitleLabel, to: detailsViewController.header.titleLabel),
         Match(tag: "pinImage", from: selectedCell.pinImageView, to: detailsViewController.header.locationIcon),
         Match(tag: "location", from: selectedCell.locationLabel, to: detailsViewController.header.locationLabel),
         Match(tag: "nextDateString", from: selectedCell.nextDateLabel, to: detailsViewController.footerView.nextDatesLabel),
         Match(tag: "month", from: selectedCell.monthLabel, to: detailsViewController.footerView.monthLabel),
         Match(tag: "dateView1", from: selectedCell.dateView1, to: detailsViewController.footerView.dateView1),
         Match(tag: "dateLabel1", from: selectedCell.dateLabel1, to: detailsViewController.footerView.dateLabel1),
         Match(tag: "dateView2", from: selectedCell.dateView2, to: detailsViewController.footerView.dateView2),
         Match(tag: "dateLabel2", from: selectedCell.dateLabel2, to: detailsViewController.footerView.dateLabel2),
         Match(tag: "dateView3", from: selectedCell.dateView3, to: detailsViewController.footerView.dateView3),
         Match(tag: "dateLabel3", from: selectedCell.dateLabel3, to: detailsViewController.footerView.dateLabel3)
      ]
      
      manager.setupTransition(from: selectedCell, inside: self, to: detailsViewController, with: matches, transitionType: .modal)
      
      present(detailsViewController, animated: true, completion: nil)
   }
}
