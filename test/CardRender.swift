//
//  CardRender.swift
//  test
//
//  Created by apple on 07/06/2018.
//  Copyright © 2018 wolfpack. All rights reserved.
//

import Foundation
import UIKit

class cardRender
{
    public func getSimbol(for card: Card) -> String
    {
        switch card.cardSimbol
        {
        case .diamond:
            return "■"
        case .oval:
            return "●"
        case .squiggle:
            return "▲"
        }
        
    }
    public func getColor(for card: Card) -> UIColor
    {
        switch card.cardColor
        {
        case .purple:
            return UIColor.purple
        case .green:
            return UIColor.green
        case .red:
            return UIColor.red
            
        }
    }
    public func getNumber(for card: Card) -> String
    {
        let simbol = getSimbol(for: card)
        switch card.cardNumber {
        case .one:
            return simbol
        case .two:
            return "\(simbol) \(simbol)"
        case .three:
            return "\(simbol) \(simbol) \(simbol)"
            
        }
    }
    public func getShading(for card: Card) -> NSAttributedString
    {
        let title = getNumber(for: card)
        let color = getColor(for: card)
        var cardAtributes: [NSAttributedStringKey:Any] = [:]
        switch card.cardShading {
        case .full:
            cardAtributes[.strokeWidth] = -1
            cardAtributes[.foregroundColor] = color.withAlphaComponent(0.0)
        case.empty:
            cardAtributes[.strokeWidth] = 5
            cardAtributes[.foregroundColor] = color.withAlphaComponent(0.0)
        case .stripped:
            cardAtributes[.strokeWidth] = -1
            cardAtributes[.foregroundColor] = color.withAlphaComponent(0.0)
        }
        
        return NSAttributedString(string: title, attributes: cardAtributes)
    }
    
    public func renderCard(for card: Card,for button: UIButton)
    {
        let buttonAtributes = getShading(for: card)
        button.setAttributedTitle(buttonAtributes, for: UIControlState.normal)
    }
}
