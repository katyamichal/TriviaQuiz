//
//  GetStartedModel.swift
//  TriviaQuiz
//
//  Created by Катя on 01.08.2025.
//

import UIKit

struct QuizQuestion {
    let title: String
    let question: String
    var options: [QuizOption]
    var correctAnswer: QuizOption
}

struct QuizOption {
    let id: String
    let title: String
    var isSelected: Bool
}

struct UserAnswer {
    let question: String
    let selectedOption: QuizOption
    let isCorrect: Bool
}
