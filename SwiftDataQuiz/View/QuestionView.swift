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
        VStack(spacing: 40) {
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                Text(sessionQuestions[questionSeq].text)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.blue)
                Text(sessionQuestions[questionSeq].category?.text ?? "General")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.blue)
                Gauge(value: gaugeProgress) {}
                .padding()
                .onAppear {
                    Task {
                        for i in 0...100 {
                            gaugeProgress = Double (i) / 100
                            try await Task.sleep(for: .milliseconds (120))
                    }
                }
            }
                
                ForEach(sessionQuestions[questionSeq].options!, id: \.id) { option in
                    AnswerRow(option: option)
                        .environment(gameManager)
                        .simultaneousGesture(
                            TapGesture().onEnded { _ in
                                proceed {
                                    if option.isCorrect {
                                        gameManager.boxes[questionSeq].hasScored = true
                                    } else {
                                        gameManager.boxes[questionSeq].hasScored = false
                                    }
                                }
                            }
                        )
                }
            }
            Spacer()
            ScoreBoardView()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color(#colorLiteral(red: 1, green: 0.9269904792, blue: 0.9197104489, alpha: 1)))
        .toolbar(.hidden)
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
        completion()
        if questionSeq < sessionQuestions.count - 1 {
            gameManager.goNext(questions: sessionQuestions, seq: questionSeq)
        } else {
            gameManager.goScore()
        }
    }
}

#Preview {
//    QuestionView(sessionQuestions: <#[Question]#>, questionSeq: 0)
}
