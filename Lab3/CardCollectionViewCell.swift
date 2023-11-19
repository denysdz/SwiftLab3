//
//  CardCollectionViewCell.swift
//  Lab3
//
//  Created by Admin on 14/11/2023.
//  Copyright © 2023 Admin. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with card: Card, delegate: CardViewDelegate) {
        cardView.configure(card: card)
        cardView.delegate = delegate
    }
    
}
