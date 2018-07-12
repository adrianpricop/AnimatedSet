//
//  IntExtension.swift
//  test
//
//  Created by apple on 05/06/2018.
//  Copyright © 2018 wolfpack. All rights reserved.
//

import Foundation

extension Int
{
    func arc4random() -> Int
    {
        if self > 0
        {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0
        {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else
        {
            return 0
        }
    }
}
