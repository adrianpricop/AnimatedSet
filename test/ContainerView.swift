//
//  ContainerView.swift
//  test
//
//  Created by apple on 13/06/2018.
//  Copyright © 2018 wolfpack. All rights reserved.
//

import UIKit

protocol DidFinishAnimating {
    func FinishedAnimating()
}

class ContainerView: UIView{

    
    var delegate : DidFinishAnimating?
    
    var animating = false
    
    var finisanimating = false
    
    var selectedCards = [Int:Card]()


    
    var inPlayCards = [Card]()
    {
        willSet
        {
            if newValue.count > inPlayCards.count
            {
                grid.cellCount = newValue.count
                
            }
        }
        didSet
        {
            if selectedCards.count != 0
            {
                if inPlayCards.count == buttons.count && inPlayCards.count < 13
                {
                    removeCards(for: true)
                }else if inPlayCards.count < buttons.count
                {
                    removeCards(for: false)
                }
            }else if inPlayCards.count == oldValue.count
            {
                updateCards()
            }
        }
    }
    
    var buttonDeckFrame = CGRect()
    
    var buttonDiscardPile = UIButton()
    
    var buttonsToAnimate = [DrawButton]()
    
    var numberOfButtons: Int = 0
    {
        didSet
        {
            
            if numberOfButtons > 0 && !animating
            {
                finisanimating = false
                uppdateView()
                addCardButtons()
            }else if numberOfButtons == 0
            {
                finisanimating = true
                DidFinishAnimating()
                uppdateView()

                
            }

        }
    }
    
    var buttons = [DrawButton]()
    
    var grid = Grid(layout: Grid.Layout.aspectRatio(8/5))
    
    func DidFinishAnimating() {


            delegate?.FinishedAnimating()

    }
    
    private var centerRect: CGRect
    {
        get
        {
            return CGRect(x: bounds.size.width * 0.025, y: bounds.size.height * 0.025, width: bounds.size.width * 0.95, height: bounds.size.height * 0.95)
        }
    }
    
    
    
    override func layoutSubviews()
    {
        grid.frame = centerRect
    }
    
    func uppdateView()
    {
        for index in buttons.indices {
            let button = buttons[index]
            if let frame = grid[index] {
                UIView.animate(withDuration: 0.2,
                               delay: 0,
                               options: [.curveEaseIn],
                               animations: {button.frame = frame},
                               completion: nil)
            }
        }
    }
    
    
    func addCardButtons()
    {
        let cardButtons = (0..<1).map { _ in DrawButton() }
        let button = cardButtons.last!
        button.frame = buttonDeckFrame

        button.layer.cornerRadius = 10
        button.layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.borderWidth = 2

        addSubview(button)

        buttons.append(button)
        

        UIView.animate(withDuration: 0.2,
                       animations: {
                        button.frame = self.grid[self.buttons.count - 1]!
                        
                        self.animating = true
                        self.layoutIfNeeded()
        },
                       completion:{ (finished) -> Void in UIView.transition(with: button,
                                                                            duration: 0.3,
                                                                            options: [.transitionFlipFromLeft],
                                                                            animations: {button.cardToDraw = self.inPlayCards[self.buttons.count - 1]
                                                                                self.buttons[self.buttons.count - 1] = button
                       },
                                                                            completion: {(finished) -> Void in self.animating = false
                                                                                self.numberOfButtons -= 1
                       })        })

    }
    
    func updateCards()
    {
        if buttons.count == inPlayCards.count
        {
            for (index, button) in buttons.enumerated()
            {
                button.cardToDraw = inPlayCards[index]
            }
        }
    }


    func removeCards(for state: Bool)
    {
        var count = 3
        for (index,_) in selectedCards
        {
            let button = buttons[index]
            
            UIView.transition(with: button,
                              duration: 0.3,
                              options: .transitionFlipFromLeft,
                              animations: {button.cardToDraw = nil
                                button.noSelect()
                                button.layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                                button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                                button.layer.borderWidth = 2},
                              completion: {(finished) -> Void in
                                UIButton.animate(withDuration: 0.5,
                                                delay: 0,
                                                options: [.curveEaseIn],
                                                animations: {button.frame = self.buttonDiscardPile.frame
                                                            self.buttons[index] = button
                                                            self.setNeedsDisplay()
                                                            },
                                                            completion:{  (finished) -> Void in button.isHidden = true
                                                                                                count -= 1
                                                                                                UIButton.animate(withDuration: 0,
                                                                                                                 delay: 0,
                                                                                                                 options: [.curveEaseIn],
                                                                                                                 animations: {button.frame = self.buttonDeckFrame
                                                                                                                            self.buttons[index] = button
                                                                                                                            self.setNeedsDisplay()},
                                                                                                                 completion:
                                                                                                    {(finished) -> Void in if !state && count == 0
                                                                                                    {
                                                                                                        self.removeButton()
                                                                                                    }else
                                                                                                    {
                                                                                                        self.replaceButtons()
                                                                                                        }}
                                                                                                    
                                                                                                )
                                                                                                
                              })})
            

        }
        
    }
    
    func removeButton()
    {
        var buttonRemoved = false
        grid.cellCount -= 1
        var index = 0
        while index < buttons.count && !buttonRemoved
        {
            if buttons[index].cardToDraw == nil
            {
                let button = buttons[index]
                button.removeFromSuperview()
                buttons.remove(at: index)
                buttonRemoved = true
            }else
            {
                index += 1
            }
        }
        selectedCards.removeAll()

        numberOfButtons = 0
    }
    
    
    func replaceButtons()
    {
        for (index,_) in selectedCards
        {
            let button = buttons[index]

            UIButton.animate(withDuration: 0.5,
                             delay: 0,
                             options: [.curveEaseIn],
                             animations: {
                                button.frame = self.grid[index]!
                                button.isHidden = false

                                self.layoutIfNeeded()
            },
                             completion:{ (finished) -> Void in UIView.transition(with: button,
                                                                                  duration: 0.3,
                                                                                  options: .transitionFlipFromLeft,
                                                                                  animations: {button.cardToDraw = self.inPlayCards[index]},
                                                                                  completion: nil)
            })

        }

        selectedCards.removeAll()
        
        numberOfButtons = 0
    }


    
    func removeAllButtons()
    {
        for button in buttons
        {
            button.removeFromSuperview()
        }
        grid.cellCount = 0
        buttons.removeAll()
        inPlayCards.removeAll()
    }
    
//    func shuffle()
//    {
//        for index in buttons.indices
//        {
//            let button = buttons[index]
//            
//    }


    

}
