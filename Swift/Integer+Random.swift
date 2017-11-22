//
//  Integer+Random.swift
//  Reisebank
//
//  Created by Alexey Matjuk on 6/12/17.
//
//

import Foundation

extension BinaryInteger {

    init(randomUpTo upperBound: UInt64) {
        self.init(arc4random_uniform(UInt32(truncatingIfNeeded: upperBound)))
    }

    init(randomUpTo upperBound: UInt32) {
        self.init(truncatingIfNeeded: UInt64(arc4random_uniform(upperBound)))
    }

    init(randomUpTo upperBound: UInt) {
        self.init(truncatingIfNeeded: UInt64(arc4random_uniform(UInt32(truncatingIfNeeded: upperBound))))
    }
    
}
