//
//  Array+Only.swift
//  Memorize
//
//  Created by Adam Akturin on 12/28/20.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
