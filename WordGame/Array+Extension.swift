//
//  Array+Extension.swift
//  WordGame
//
//  Created by Max Lampert on 12/22/15.
//  Copyright © 2015 Max Lampert. All rights reserved.
//

import Foundation

extension Array {
    func chooseOne() -> Element {
        return self[Int(arc4random_uniform(UInt32(self.count)))]
    }
}