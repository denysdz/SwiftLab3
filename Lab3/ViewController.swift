//
//  ViewController.swift
//  Lab3
//
//  Created by Admin on 10/10/2023.
//  Copyright © 2023 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var game:Game!
    
    var isHidden = false
    
    let initialCount = 14
    
     let itemsPerRow = 3
    
    var lastCard:Card? = nil
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var labelCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        reloadGame(initialCount)
    }
    
    @IBAction func addPairAction (_ sender: UIButton) {
        var cardCount = game.cardsCount
        cardCount += 2
        reloadGame(cardCount)
    }
    
    @IBAction func minusAction (_ sender: UIButton) {
        var cardCount = game.cardsCount
        if (cardCount >= 4) {
            cardCount -= 2
            reloadGame(cardCount)
        }
    }
    
    func loadIcons () {
        /*
        for i in 0..<game.cards.count {
            cardViews[i].configure(card: game.cards[i])
            cardViews[i].delegate = self
        }
        */
    }
    
    func reloadGame (_ cardCount: Int) {
        game = Game(count: cardCount)
        collectionView.reloadData()
        labelCount.text = "Pair count \(cardCount)"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.cardsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        let row = indexPath.item / itemsPerRow
        let column = indexPath.item % itemsPerRow
        let currentIndex = row*itemsPerRow+column
        cell.configure(with: game.cards[currentIndex], delegate: self)
        return cell
    }
    
    func getCellById(id: Int) -> UICollectionViewCell? {
        var index = id
        var foundIndexPath: IndexPath?

        for section in 0..<self.collectionView.numberOfSections {
            if index < self.collectionView.numberOfItems(inSection: section) {
                foundIndexPath = IndexPath(item: index, section: section)
                break
            } else {
                index -= self.collectionView.numberOfItems(inSection: section)
            }
        }

        if let indexPath = foundIndexPath,
           let cell = self.collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell {
            return cell
        }

        return nil
    }
    
}

extension ViewController: CardViewDelegate {
    
    
    func didClicked(id: Int, sender: CardView) {
        guard let lastCard = lastCard else {
            self.lastCard = sender.card
            return
        }
        
        guard lastCard != sender.card else {
            if let cell = getCellById(id: id) as? CardCollectionViewCell {
                cell.cardView.flipBack()
            }
            self.lastCard = nil
            return
        }
        
        if !game.checkForMatch(lastCard, sender.card) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: { [weak self] in
                if let cell = self?.getCellById(id: lastCard.id) as? CardCollectionViewCell {
                    cell.cardView.flipBack()
                }
                if let cell = self?.getCellById(id: id) as? CardCollectionViewCell {
                    cell.cardView.flipBack()
                }
            })
        } else {
            if game.isGameWon() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: { [weak self] in
                     let alert = UIAlertController(title: "Game Info", message: "Game Win!", preferredStyle: .alert)
                                  alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { [weak self] _ in
                                    guard let vc = self else { return }
                                    vc.reloadGame(vc.game.cardsCount)
                                  }))
                                  self?.present(alert, animated: true, completion: nil)
                })
            }
        }
        self.lastCard = nil
    }
    
}
