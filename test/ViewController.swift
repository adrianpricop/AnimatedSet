//
//  ViewController.swift
//  test
//
//  Created by apple on 05/06/2018.
//  Copyright © 2018 wolfpack. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DidFinishAnimating
{
    override func viewDidLoad() {
        super.viewDidLoad()
        game.cardGenerator()
        drawThreeCardsButton.noSelect()
        showSetButton.noSelect()
        newGameButton.noSelect()
        scoreBord.layer.masksToBounds = true
        scoreBord.layer.cornerRadius = 10
        cardsContainerView.inPlayCards = game.inPlayCards
        updateViewFromModel()
        cardsContainerView.delegate = self
        drawThreeCardsButton.isEnabled = false
        showSetButton.isEnabled = false
        newGameButton.isEnabled = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cardsContainerView.buttonDeckFrame = CGRect(x: drawThreeCardsButton.frame.origin.x ,
                                                y: drawThreeCardsButton.frame.origin.y - drawThreeCardsButton.frame.height - 8 ,
                                                width: drawThreeCardsButton.frame.width,
                                                height: drawThreeCardsButton.frame.height)
        cardsContainerView.buttonDiscardPile = showSetButton
        cardsContainerView.inPlayCards = game.inPlayCards
        cardsContainerView.numberOfButtons += game.inPlayCards.count
        updateViewFromModel()
    }
    
        
    @IBOutlet var draw3Cards: UISwipeGestureRecognizer!
    
    @IBAction func draw3Cards(_ sender: UISwipeGestureRecognizer) {
        if game.deck.count > 2 {
            game.drawThreeCards()
            cardsContainerView.inPlayCards = game.inPlayCards
            cardsContainerView.numberOfButtons += 3
            updateViewFromModel()
        }
        if game.deck.count < 3 {
            drawThreeCardsButton.isHidden = true
        }
        drawThreeCardsButton.isEnabled = false
        showSetButton.isEnabled = false
        newGameButton.isEnabled = false
    }
    
    @IBOutlet var shuffleCards: UIRotationGestureRecognizer!
    
    @IBAction func shuffleCards(_ sender: Any) {
//        game.shuffleCards()
//        updateViewFromModel()
//        cardsContainerView.inPlayCards = game.inPlayCards
        
    }
    
    @IBOutlet weak var cardsContainerView: ContainerView!
    @IBOutlet weak var drawThreeCardsButton: UIButton!
    @IBOutlet weak var showSetButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var scoreBord: UILabel!
    
    var game = SetGame()
    
    func FinishedAnimating() {
        addTaregetFunc()
        drawThreeCardsButton.isEnabled = true
        showSetButton.isEnabled = true
        newGameButton.isEnabled = true
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        game.newGame()
        cardsContainerView.inPlayCards.removeAll()
        cardsContainerView.removeAllButtons()
        cardsContainerView.inPlayCards = game.inPlayCards
        cardsContainerView.numberOfButtons = game.inPlayCards.count
        drawThreeCardsButton.isHidden = false
    }
    
    @IBAction func showSet(_ sender: UIButton) {
        if game.findSet() {
            updateViewFromModel()
            cardsContainerView.inPlayCards = game.inPlayCards
        }
    }
    
    @IBAction func drawThreeCards(_ sender: UIButton) {
        if game.deck.count > 2 {
            game.drawThreeCards()
            cardsContainerView.inPlayCards = game.inPlayCards
            cardsContainerView.numberOfButtons += 3
            updateViewFromModel()
        }
        if game.deck.count < 3 {
            drawThreeCardsButton.isHidden = true
        }
        drawThreeCardsButton.isEnabled = false
        showSetButton.isEnabled = false
        newGameButton.isEnabled = false
    }

    func addTaregetFunc() {
        for button in cardsContainerView.buttons {
            button.addTarget(self, action: #selector(didTapCard), for: .touchUpInside)
        }
    }

    @objc func didTapCard(sender: UIButton) {
        let index = cardsContainerView.buttons.index(of: sender as! DrawButton)!
        game.selectCard(at: index)
        if game.selectedCards.count == 3 {
            cardsContainerView.inPlayCards = game.inPlayCards
            if game.isSet(for: game.selectedCards) {
                cardsContainerView.selectedCards = game.selectedCards
                game.verifySelectedCards()
                cardsContainerView.inPlayCards = game.inPlayCards
            }
        }else {
            cardsContainerView.inPlayCards = game.inPlayCards
        }
        updateViewFromModel()
        
    }
    func updateViewFromModel() {
        let score = game.score
        scoreBord.text = "score: \(score)"
    }    
}


