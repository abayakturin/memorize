//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Adam Akturin on 12/22/20.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture{
                    self.viewModel.choose(card: card)
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(.orange)
            
            Button(action: {
                self.viewModel.startNewGame()
            }, label: {
                Text("Start new game")
                .fontWeight(.bold)
                .font(.title)
                .padding()
                .background(Color.orange)
                .cornerRadius(40)
                .foregroundColor(.white)
            })
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) ->  some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius:  cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame.init())
        }
    }
}
