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
            if cell.card?.isFlipped == false {
                cell.flipUP()
            } 
            
            // unabling user flips the card manually
//            else {
//                cell.flipDown()
//            }
        }
    }
}
