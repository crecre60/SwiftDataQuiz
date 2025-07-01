//
//  SwiftDataQuizApp.swift
//  SwiftDataQuiz
//
//  Created by Young Jin Ju on 6/24/25.
//

import SwiftUI

@main
struct SwiftDataQuizApp: App {
    @State private var gameManager: GameManager = .init()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $gameManager.paths) {
                WelcomeView()
                    .navigationDestination(for: Paths.self) { path in
                        switch path {
                            case .gamePath(let questions, let seq):
                                QuestionView(sessionQuestions: questions, questionSeq: seq)
                            case .scorePath(let score, let total):
                                ScoreView(score: score, total: total)
                        }
                    }
            }
            .environment(gameManager)
        }
        .modelContainer(for: Question.self)
    }
}

