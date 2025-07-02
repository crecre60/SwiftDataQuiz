//
//  WelcomeView.swift
//  SwiftDataQuiz
//
//  Created by Young Jin Ju on 6/20/25.
//

import SwiftUI
import SwiftData

struct WelcomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allQuestions: [Question]

    @Environment(GameManager.self) private var gameManager
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Text("Swfit Data Quiz")
                .font(.largeTitle)
            Spacer()
            Button {
                gameManager.paths.append(
                    .gamePath(allQuestions.shuffled().dropLast(25), 0)
                )
            } label: {
                Image(systemName: "stopwatch")
                    .font(.largeTitle)
                    .foregroundStyle(.blue)
                    
            }
            Spacer()
        }
        .formatVStack()
        .foregroundColor(.gray)
        .onAppear {
            gameManager.score = 0
        }
    }
}

#Preview {
    WelcomeView()
}

extension View {
    func formatVStack() -> some View {
        return padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color(#colorLiteral(red: 1, green: 0.9269904792, blue: 0.9197104489, alpha: 1)))
        .toolbar(.hidden)
    }
}
