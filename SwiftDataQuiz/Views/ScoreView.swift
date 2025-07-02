//
//  ScoreView.swift
//  SwiftDataQuiz
//
//  Created by Young Jin Ju on 6/28/25.
//

import SwiftUI
import SwiftData

struct ScoreView: View {
    @Environment(GameManager.self) private var gameManager
    @Environment(\.modelContext) private var modelContext
    @Query private var categories: [Category]
    
    var score, total: Int
    var categoryNames: [String] {
        categories.map {
            $0.text
        }
    }
    var ratioByCategory: [Double] {
        categories.map {
            $0.numberOfQuestionsPresented == 0 ? 0 : Double($0.numberOfCorrectAnswersPresented!) / Double($0.numberOfQuestionsPresented!) * 100
        }
    }
    
    var numberOfSuccessesInCategory: [Int] {
        categories.map {
            $0.numberOfCorrectAnswersPresented ?? 0
        }
    }
    var numberOfQuestionsInCategory: [Int] {
        categories.map {
            $0.numberOfQuestionsPresented ?? 0
        }
    }
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Text("Game result")
                .font(.largeTitle)
                .foregroundStyle(.blue)
            List {
                ForEach(categoryNames.indices) { index in
                    Text("\(categoryNames[index]) - \(ratioByCategory[index])%")
                    Text(": \(numberOfSuccessesInCategory[index]) out of \(numberOfQuestionsInCategory[index])")
                }
                .foregroundStyle(.blue)
            }
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
