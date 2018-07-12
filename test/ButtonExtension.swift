//
//  ButtonExtension.swift
//  test
//
//  Created by apple on 05/06/2018.
//  Copyright © 2018 wolfpack. All rights reserved.
//

import Foundation
import UIKit

extension UIButton
{
    func select()
    {
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
    }
    
    func deselect()
    {
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    }
    
    func noSelect()
    {
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 10
    }
}
