//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Adam Akturin on 12/22/20.
//

import SwiftUI

let game = EmojiMemoryGame()

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Theme: " + self.viewModel.getThemeName())
                .fontWeight(.bold)
                .font(.title3)
                .padding()
                .background(Color.white)
                .cornerRadius(50)
                .foregroundColor(.black)
            
            Text("Score: " + String(self.viewModel.returnScore()))
                .font(.title3)
                .background(Color.white)
                .foregroundColor(.black)
            
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture{
                    withAnimation(.linear(duration: 0.5)){
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(game.getThemeColor().color)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.viewModel.startNewGame()
                }
            }, label: {
                Text("Start new game")
                .fontWeight(.bold)
                .font(.title)
                .padding()
                .background(game.getThemeColor().color)
                .cornerRadius(40)
                .foregroundColor(Color.white)
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
    
    @ViewBuilder
    private func body(for size: CGSize) ->  some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(20), clockWise: true).padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
            .rotation3DEffect(
                Angle.degrees(card.isFaceUp ? 0 : 180),
                axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/)
        }
    }
    
    // MARK: - Drawing Constants
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        return EmojiMemoryGameView(viewModel: EmojiMemoryGame.init())
        return EmojiMemoryGameView(viewModel: game)
    }
}
