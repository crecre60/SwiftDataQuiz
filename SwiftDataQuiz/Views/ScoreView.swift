//
//  ScoreView.swift
//  SwiftDataQuiz
//
//  Created by Young Jin Ju on 6/28/25.
//

import SwiftUI

struct ScoreView: View {
    @Environment(GameManager.self) private var gameManager
    var score, total: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Text("Game result")
                .font(.largeTitle)
                .foregroundStyle(.blue)
            Spacer()
            Text("\(score)/\(total)")
                .font(.title)
                .foregroundStyle(.black)
            Spacer()
            Button("Play again") {
                gameManager.score = 0
                gameManager.paths.removeAll()
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color(#colorLiteral(red: 1, green: 0.9269904792, blue: 0.9197104489, alpha: 1)))
        .toolbar(.hidden)
    }
}

#Preview {
    ScoreView(score: 9, total: 10)
}
