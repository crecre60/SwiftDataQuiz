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
        .formatVStack()
    }
}

#Preview {
    ScoreView(score: 9, total: 10)
}
