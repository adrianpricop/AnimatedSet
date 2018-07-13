//
//  Card.swift
//  test
//
//  Created by apple on 05/06/2018.
//  Copyright © 2018 wolfpack. All rights reserved.
//

import Foundation


struct Card: Hashable {
    

    var matching = false
    var isSelected = false
    var identifier: Int
    
    let cardColor: CardColor 
    let cardSimbol: CardSimbol
    let cardNumber: CardNumber
    let cardShading: CardShading
    
    var hashValue: Int {
        return identifier.hashValue
    }
    
    static func == (lhs: Card ,rhs: Card) ->Bool {
        return lhs.identifier == rhs.identifier
    }

    enum CardSimbol {
        case diamond
        case oval
        case squiggle

        static let allValues = [diamond, oval, squiggle]
    }
    
    enum CardColor {
        case red
        case green
        case purple

        static let allValues = [red, green, purple]
    }
    
    enum CardNumber {
        case one
        case two
        case three

        static let allValues = [one, two, three]
    }
    
    enum CardShading {
        case full
        case empty
        case stripped

        static let allValues = [full, empty, stripped]
    }
}
