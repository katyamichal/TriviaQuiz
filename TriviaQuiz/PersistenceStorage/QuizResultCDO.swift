//
//  QuizResultCDO.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import Foundation
struct QuizResultCDO: Entity {
    var typeName: EntityType { .quizResult }
    let id: String
    let passDate: Date
    let rating: Int
}

extension QuizResultCDO {
    init( rating: Int) {
        self.id = UUID().uuidString
        self.passDate = Date()
        self.rating = rating
    }
}
