//
//  QuestionView.swift
//  SwiftDataQuiz
//
//  Created by Young Jin Ju on 6/30/25.
//

import SwiftUI
import SwiftData

struct QuestionView: View {
    @Environment(GameManager.self) private var gameManager
    @State var gaugeProgress = 0.0
    var sessionQuestions: [Question]
    var questionSeq: Int

    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                Text(sessionQuestions[questionSeq].category?.text ?? "General")
                    .italic()
                    .font(.caption)
                    .bold()
                    .foregroundStyle(.gray)
                
                Text(sessionQuestions[questionSeq].text)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.gray)
                
                Gauge(value: gaugeProgress) {}
                    .gaugeStyle(.accessoryLinear)
                    .tint(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .padding()
                    .onAppear {
                        Task {
                            for i in 0...100 {
                                gaugeProgress = Double(i) / 100
                                try await Task.sleep(for: .milliseconds(120))
                            }
                        }
                    }
                
                OptionsView(sessionQuestions: sessionQuestions,
                            currentQuestionSeq: questionSeq,
                            currentOptions: sessionQuestions[questionSeq].options!)
            }
            Spacer()
            
            ScoreBoardView()
        }
        .formatVStack()
        .onChange(of: gaugeProgress) { oldValue, newValue in
            if newValue >= 1 {
                proceed {
                    gameManager.boxes[questionSeq].hasScored = false
                }
            }
        }
    }
}

extension QuestionView {
    private func proceed(completion: @escaping () -> Void) {
        Task {
            completion()
            try? await Task.sleep(for: .seconds(1))
            if questionSeq < sessionQuestions.count - 1 {
                gameManager.goNext(questions: sessionQuestions, seq: questionSeq)
            } else {
                gameManager.goScore()
            }
        }
    }
}
