//
//  ViewController.swift
//  MatchApp
//
//  Created by Sergey A on 02.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cardModel = CardModel()
    var cardsArray = [Card]()
    
    // Keep track of flipped cards
    var firstFlippedCardIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cardsArray = cardModel.getCards()
        
        // Set the view controller as the datasource and delegate of the collection view
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
}


// MARK: - UICollectionView Data Source

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Return number of cards
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Get a cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! Cell
        
        // Get the card from the card array
        let touchedCard = cardsArray[indexPath.row]
        
        // TODO: Finish configuring the cell
        cell.configureCell(card: touchedCard)
        
        // Return it
        return cell
    }
}


// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get the reference to the cell that was tapped
        if let cell = collectionView.cellForItem(at: indexPath) as? Cell {
            
            //Check the status of the card to determine how to flip it
            if cell.card?.isFlipped == false && cell.card?.isMatched == false {
                
                // Flip the card up
                cell.flipUp()
                
                // Check whether this is the first flipped card or the second
                if firstFlippedCardIndex == nil {
                    
                    // This is the first flipped card
                    firstFlippedCardIndex = indexPath
                    
                } else {
                    
                    // Second card that is flipped
                    
                    // Run the comparison logic
                    checkForMatch(indexPath)
                }
            }
        }
        
        // MARK: - Game Logic Method
        func checkForMatch(_ secondFlippedCardIndex: IndexPath) {
            
            // Get the two card objects for the two indices and see if they match
            let cardOne = cardsArray[firstFlippedCardIndex!.row]
            let cardTwo = cardsArray[secondFlippedCardIndex.row]
            
            // Get the two collection view cells that represent card one and card two
            
            let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? Cell
            let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? Cell
            
            
            // Compare the two cards
            if cardOne.imageName == cardTwo.imageName {
                // It is a match
                
                // Set the status and remove them
                cardOne.isMatched = true
                cardTwo.isMatched = true
                
                cardOneCell?.remove()
                cardTwoCell?.remove()
                
            } else {
                
                // It is not a match
                
                // Flip them back over
            
                cardOneCell?.flipDown()
                cardTwoCell?.flipDown()
            }
            
            // Reset the firstFlippedCardIndex property
            firstFlippedCardIndex = nil
        }
    }
}
