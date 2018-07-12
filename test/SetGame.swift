//
//  SetGame.swift
//  test
//
//  Created by apple on 05/06/2018.
//  Copyright © 2018 wolfpack. All rights reserved.
//

import Foundation

class SetGame
{
    var inPlayCards = [Card]()
    
    var deck = [Card]()
    
    var score = 0
    
    var selectedCards = [Int:Card]()
    
    var isSetCards = [Int:Card]()
    
    func cardGenerator()
    {
        var identifier = 0
        for color in Card.CardColor.allValues
        {
            for simbol in Card.CardSimbol.allValues
            {
                for number in Card.CardNumber.allValues
                {
                    for shading in Card.CardShading.allValues
                    {
                        let card = Card(matching: false, isSelected: false, identifier: identifier, cardColor: color, cardSimbol: simbol, cardNumber: number, cardShading: shading)
                        deck.append(card)
                        identifier += 1
                    }
                }
            }
        }

        drawCards()

    }
    
    func drawCards()
    {
        for _ in 0..<12
        {
            let index = deck.count.arc4random()
            inPlayCards.append(deck[index])
            deck.remove(at: index)
        }
        
    }
    
    func returnCard(for index: Int) -> Card
    {
        
        return inPlayCards[index]
    }
    
    func drawThreeCards()
    {
        if deck.count > 1
        {
            if findSet()
            {
                for (index, _) in isSetCards
                {
                    inPlayCards[index].matching = false
                }
                isSetCards.removeAll()
                
            }
            for _ in 0...2
            {
                let index = deck.count.arc4random()
                inPlayCards.append(deck[index])
                deck.remove(at: index)
                for (idexes, _) in selectedCards
                {
                    inPlayCards[idexes].isSelected = false
                }
                selectedCards.removeAll()
            }
        }
    }
    
    func selectCard(at index: Int)
    {
        isSetCards.removeAll()
        if index < inPlayCards.count
        {
            if selectedCards.count < 3
            {
                
                if selectedCards.index(forKey: index) != nil
                {
                    
                    selectedCards.removeValue(forKey: index)
                    inPlayCards[index].isSelected = false
                    
                }else
                {
                    inPlayCards[index].isSelected = true
                    selectedCards[index] = inPlayCards[index]
                }
            }

//            if selectedCards.count == 3
//            {
//                if isSet(for :selectedCards)
//                {
//                    score += 10
//                    for (indexes, _) in selectedCards
//                    {
//                        if inPlayCards.count < 13 && deck.count > 0
//                        {
//                            let newIndex = deck.count.arc4random()
//                            inPlayCards[indexes] = deck[newIndex]
//                            deck.remove(at: newIndex)
//                        }else
//                        {
//                            
//                            for newindex in inPlayCards.indices
//                            {
//                                let card = selectedCards[indexes]
//                                if inPlayCards[newindex] == card!
//                                {
//                                    inPlayCards.remove(at: newindex)
//                                    break
//                                }
//                            }
//                        }
//                    }
//                }else
//                {
//                    score -= 2
//                    for (indexes, _) in selectedCards
//                    {
//                        inPlayCards[indexes].isSelected = false
//                    }
//                }
//                selectedCards.removeAll()
//            }
        }

    }
    
    func verifySelectedCards()
    {
        if selectedCards.count == 3
        {
            if isSet(for :selectedCards)
            {
                score += 10
                for (indexes, _) in selectedCards
                {
                    if inPlayCards.count < 13 && deck.count > 0
                    {
                        let newIndex = deck.count.arc4random()
                        inPlayCards[indexes] = deck[newIndex]
                        deck.remove(at: newIndex)
                    }else
                    {
                        
                        for newindex in inPlayCards.indices
                        {
                            let card = selectedCards[indexes]
                            if inPlayCards[newindex] == card!
                            {
                                inPlayCards.remove(at: newindex)
                                break
                            }
                        }
                    }
                }
            }else
            {
                score -= 2
                for (indexes, _) in selectedCards
                {
                    inPlayCards[indexes].isSelected = false
                }
            }
            selectedCards.removeAll()
        }
    }
    
    func findSet() -> Bool
    {
        isSetCards.removeAll()
        for card1 in 0..<inPlayCards.count - 2
        {
            inPlayCards[card1].matching = true
            isSetCards[card1] = inPlayCards[card1]
            for card2 in card1 + 1..<inPlayCards.count - 1
            {
                inPlayCards[card2].matching = true
                isSetCards[card2] = inPlayCards [card2]
                for card3 in card2 + 1..<inPlayCards.count
                {
                    inPlayCards[card3].matching = true
                    isSetCards[card3] = inPlayCards[card3]
                    if isSet(for: isSetCards)
                    {
                        for (indexes, _) in selectedCards
                        {
                            inPlayCards[indexes].isSelected = false
                        }
                        selectedCards.removeAll()
                        score -= 5
                        return true
                    }
                    inPlayCards[card3].matching = false
                    isSetCards.removeValue(forKey: card3)
                }
                inPlayCards[card2].matching = false
                isSetCards.removeValue(forKey: card2)
            }
            inPlayCards[card1].matching = false
            isSetCards.removeValue(forKey: card1)
        }
        return false
    }
    func isSet(for matchedCards: [Int:Card]) -> Bool
    {
        var cards = [Card]()
        for (indexes, _)in matchedCards
        {
            cards.append(matchedCards[indexes]!)

        }
        if !(cards[0].cardColor == cards[1].cardColor && cards[0].cardColor == cards[2].cardColor || cards[0].cardColor != cards[1].cardColor && cards[0].cardColor != cards[2].cardColor && cards[1].cardColor != cards[2].cardColor)
        {
            return false
        }
        
        if !(cards[0].cardNumber == cards[1].cardNumber && cards[0].cardNumber == cards[2].cardNumber || cards[0].cardNumber != cards[1].cardNumber && cards[0].cardNumber != cards[2].cardNumber && cards[1].cardNumber != cards[2].cardNumber)
        {
            return false
        }
        
        if !(cards[0].cardSimbol == cards[1].cardSimbol && cards[0].cardSimbol == cards[2].cardSimbol || cards[0].cardSimbol != cards[1].cardSimbol && cards[0].cardSimbol != cards[2].cardSimbol && cards[1].cardSimbol != cards[2].cardSimbol)
        {
            return false
        }
        
        if !(cards[0].cardShading == cards[1].cardShading && cards[0].cardShading == cards[2].cardShading || cards[0].cardShading != cards[1].cardShading && cards[0].cardShading != cards[2].cardShading && cards[1].cardShading != cards[2].cardShading)
        {
            return false
        }
        return true
    }
    
    func newGame()
    {
        score = 0
        selectedCards.removeAll()
        inPlayCards.removeAll()
        deck.removeAll()
        cardGenerator()
    }
    
    func shuffleCards()
    {
        var shuffledCards = [Card]()
        
        for (indexes, _) in selectedCards
        {
            inPlayCards[indexes].isSelected = false
        }
        selectedCards.removeAll()
        
        for _ in 0..<inPlayCards.count
        {
            let randomIndex = inPlayCards.count.arc4random()
            shuffledCards.append(inPlayCards[randomIndex])
            inPlayCards.remove(at: randomIndex)
        }
        inPlayCards = shuffledCards
        shuffledCards.removeAll()
    }
    

    
}
