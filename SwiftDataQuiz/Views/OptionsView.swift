//
//  OptionsView.swift
//  SwiftDataQuiz
//
//  Created by Young Jin Ju on 7/1/25.
//

import SwiftUI

struct OptionsView: View {
    @Environment(GameManager.self) private var gameManager
    var sessionQuestions: [Question]
    var currentQuestionSeq: Int
    var currentOptions: [Option]
    var shuffledOptions: [Option] {
        return currentOptions.shuffled()
    }

    var body: some View {
        ForEach(shuffledOptions, id: \.id) { option in
            AnswerOption(option: option)
                .environment(gameManager)
                .simultaneousGesture(
                    TapGesture().onEnded { _ in
                        proceed {
                            if option.isCorrect {
                                gameManager.boxes[currentQuestionSeq].hasScored = true
                            } else {
                                gameManager.boxes[currentQuestionSeq].hasScored = false
                            }
                        }
                    }
                )
        }
    }
}

extension OptionsView {
    private func proceed(completion: @escaping () -> Void) {
        Task {
            completion()
            try? await Task.sleep(for: .seconds(1))
            if currentQuestionSeq < sessionQuestions.count - 1 {
                gameManager.goNext(questions: sessionQuestions, seq: currentQuestionSeq)
            } else {
                gameManager.goScore()
            }
        }
    }
}
