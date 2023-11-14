//
//  ViewController.swift
//  Lab3
//
//  Created by Admin on 10/10/2023.
//  Copyright © 2023 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game:Game!
    
    var isHidden = false
    
    var lastCard:Card? = nil
    
    @IBOutlet var cardViews: [CardView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pairCount = cardViews.count / 2
        game = Game(count: pairCount)
        loadIcons()
    }
    
    func loadIcons () {
        for i in 0..<game.cards.count {
            cardViews[i].configure(card: game.cards[i])
            cardViews[i].delegate = self
        }
    }
}

extension ViewController: CardViewDelegate {
    
    
    func didClicked(sender: CardView) {
        guard let lastCard = lastCard else {
            self.lastCard = sender.card
            return
        }
        
        guard lastCard != sender.card else {
            cardViews[sender.card.id].flipBack()
            self.lastCard = nil
            return
        }
        
        if !game.checkForMatch(lastCard, sender.card) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: { [weak self] in
                self?.cardViews[lastCard.id].flipBack()
                self?.cardViews[sender.card.id].flipBack()
            })
        } else {
            if game.isGameWon() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: { [weak self] in
                     let alert = UIAlertController(title: "Game Info", message: "Game Win!", preferredStyle: .alert)
                                  alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                  NSLog("The \"OK\" alert occured.")
                                  }))
                                  self?.present(alert, animated: true, completion: nil)
                })
              
            }
        }
        
        self.lastCard = nil
    }
    
    
}
