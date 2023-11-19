//
//  CardView.swift
//  Lab3
//
//  Created by Admin on 24/10/2023.
//  Copyright © 2023 Admin. All rights reserved.
//

import UIKit

protocol CardViewDelegate: AnyObject {
    func didClicked(id: Int, sender: CardView)
}

class CardView: NibLoadingView {

    @IBOutlet weak var btn : UIButton!
    
    @IBOutlet weak var topCard: UIView!
    
    @IBOutlet weak var bottomCard: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var card:Card!
    
    weak var delegate: CardViewDelegate?
    
    @IBAction func buttonTapped(_ sender:UIButton){
        if (card.isMatched) {
            return
        }
        if (!card.isFaceUp) {
            flipTop()
        } else {
            flipBack()
        }
        delegate?.didClicked(id: card.id, sender: self)
    }
    
    func flipTop () {
        topCard.flip(to: bottomCard, with: .transitionFlipFromLeft)
        card.isFaceUp = true
    }
    
    func flipBack () {
        bottomCard.flip(to: topCard, with: .transitionFlipFromLeft)
        card.isFaceUp = false
    }
    
    func configure (card:Card) {
        self.card = card
        imageView.image = UIImage(named: card.img)
    }
    

}

extension UIView {
    func flip(to view:UIView, with option: AnimationOptions) {
        UIView.transition(from: self, to: view, duration: 0.5, options: [option, .showHideTransitionViews])
    }
}
