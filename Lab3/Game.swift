//
//  Game.swift
//  Lab3
//
//  Created by Admin on 11/10/2023.
//  Copyright © 2023 Admin. All rights reserved.
//

import UIKit


class Game {
    
    let cardsCount:Int
    let cardsSrs:[String] = [
        "card_1",
        "card_2",
        "card_3",
        "card_4",
        "card_5",
        "card_6"
    ]
    var cards: [Card] = []
    
    init (count maxCount:Int) {
        cardsCount = maxCount
        for index in 0..<maxCount {
            let randomInt = Int.random(in: 0..<cardsSrs.count)
            for column in 0..<2 {
                let currentIndex = index*2+column
                cards.append(Card(id: currentIndex, img: cardsSrs[randomInt], isFaceUp: false, isMatched: false))
            }
        }
    }
    
    func flipCard(at index: Int) {
        
    }
    
    func checkForMatch(_ firstCard:Card, _ lastCard:Card) -> Bool {
        if (firstCard.img == lastCard.img) {
            cards[firstCard.id].isMatched = true
            cards[lastCard.id].isMatched = true
            return true
        } else {
            return false
        }
    }
    
    
    
    func isGameWon() -> Bool {
        for card in cards {
            if !card.isMatched {
                return false
            }
        }
        return true
    }
    
    func restartGame() {
        
    }
    
}
