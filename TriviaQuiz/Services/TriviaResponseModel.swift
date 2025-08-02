//
//  TriviaResponseModel.swift
//  TriviaQuiz
//
//  Created by Катя on 01.08.2025.
//

import Foundation

struct QuizRequest {
    var amount: Int
    var type: String
    var category: Int
    var difficulty: String
    
    static let `default` = QuizRequest(amount: 5, type: "multiple", category: 9, difficulty: "easy")
}

struct QuizResponse: Decodable {
    let results: [Quiz]
}

struct Quiz: Decodable {
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
