//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Adam Akturin on 12/24/20.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
     
    static func createMemoryGame() -> MemoryGame<String> {
        
        
        
        var emojis_ = [String]()
        var emojis = [String]()
        let emojisSize = Int.random(in: 2..<6)
        
        for i in 0x1F601...0x1F64F {
            let c = String(UnicodeScalar(i) ?? "-")
            
            emojis_.append(c)
        }
        
        emojis_.shuffle()
        
        for emoji in emojis_{
            
            let add = arc4random()
            
            if add != 0 && emojis.count < emojisSize {
                emojis.append(emoji)
            }
        }
        
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the model
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
    
    // MARK: - Start new game
    func startNewGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
