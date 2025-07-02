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
            OptionView(option: option)
                .environment(gameManager)
                .simultaneousGesture(
                    TapGesture().onEnded { _ in
                        proceed {
                            sessionQuestions[currentQuestionSeq].category?.numberOfQuestionsPresented! += 1
                            if option.isCorrect {
                                gameManager.boxes[currentQuestionSeq].hasScored = true
                                if sessionQuestions[currentQuestionSeq].category?.numberOfCorrectAnswersPresented != nil {
                                    sessionQuestions[currentQuestionSeq].category?.numberOfCorrectAnswersPresented! += 1
                                } else {
                                    sessionQuestions[currentQuestionSeq].category?.numberOfCorrectAnswersPresented = 1
                                }
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
            if gameManager.isQuestionTried {
                if currentQuestionSeq < sessionQuestions.count - 1 {
                    gameManager.goNext(questions: sessionQuestions, seq: currentQuestionSeq)
                } else {
                    gameManager.goScore()
                }
                gameManager.isQuestionTried = false
            }
        }
    }
}
