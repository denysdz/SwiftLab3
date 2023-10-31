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
        for _ in 0..<maxCount {
            for _ in 0..<2 {
                let randomInt = Int.random(in: 0..<cardsSrs.count)
                cards.append(Card(id: 0, img: cardsSrs[randomInt], isFaceUp: false, isMatched: false))
            }
        }
    }
    
    func flipCard(at index: Int) {}
    
    func checkForMatch() {}
    
    func isGameWon() -> Bool {
        return false
    }
    
    func restartGame() {}
    
}
