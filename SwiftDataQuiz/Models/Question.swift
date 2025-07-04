//
//  Question.swift
//  SwiftDataQuiz
//
//  Created by Young Jin Ju on 6/20/25.
//

import Foundation
import SwiftData

@Model
class Category: Identifiable {
    var text: String
    var questions: [Question]?
    @Transient var numberOfQuestionsPresented: Int? = 0
    @Transient var numberOfCorrectAnswersPresented: Int? = 0

    init(text: String) {
        self.text = text
    }
}

@Model
class Question: Hashable, Identifiable {
    var text: String
    var category: Category?
    
    @Relationship(deleteRule: .cascade, inverse: \Option.question) var options: [Option]?
    var explanation: Explanation?

    init(text: String) {
        self.text = text
    }
}

@Model
class Option: Identifiable {
    var text: String
    var question: Question?
    var isCorrect: Bool
    
    init(text: String, isCorrect: Bool) {
        self.text = text
        self.isCorrect = isCorrect
    }
}

@Model
class Explanation: Identifiable {
    var text: String
    var question: Question?
    
    init(text: String) {
        self.text = text
    }
}
