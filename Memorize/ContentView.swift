//
//  ContentView.swift
//  Memorize
//
//  Created by Adam Akturin on 12/22/20.
//

import SwiftUI

let game = EmojiMemoryGame()

struct ContentView: View {
    var viewModel: EmojiMemoryGame

    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture{
                    self.viewModel.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var width = UIScreen.main.bounds.width / CGFloat(game.cards.count + 4)
    var fontSize = game.cards.count == 5 ? Font.largeTitle : Font.title
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius:  10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
        .font(fontSize)
        .frame(width: width, height: width * 1.5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(viewModel: game)
        }
    }
}
