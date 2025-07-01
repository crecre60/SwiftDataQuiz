import SwiftUI
import SwiftData

enum Paths: Hashable {
    case gamePath([Question], Int)
    case scorePath(correct: Int, total: Int)
}

@Observable class GameManager {
    var paths: [Paths] = []
    var boxes: [ScoreBox] = [
        ScoreBox(),
        ScoreBox(),
        ScoreBox(),
        ScoreBox(),
        ScoreBox(),
        ScoreBox(),
        ScoreBox(),
        ScoreBox(),
        ScoreBox(),
        ScoreBox()
    ]

    var score = 0
    private(set) var isQuestionTried = false
    
    
    func goNext(questions: [Question], seq: Int) {
        isQuestionTried = false
        paths.append(.gamePath(questions, seq + 1))
    }
    
    func goScore() {
        boxes.forEach { $0.hasScored = nil }
        paths.append(.scorePath(correct: score, total: boxes.count))
    }

    func chooseOption(option: Option) {
        isQuestionTried = true
        
        if option.isCorrect {
            score += 1
        }
    }
}
