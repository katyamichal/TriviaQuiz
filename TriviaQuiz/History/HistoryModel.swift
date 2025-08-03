//
//  HistoryModel.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import Foundation

struct HistoryQuiz: Decodable {
    let id: UUID
    let quizName: String

    /// Время спрохождения.
    let created: String
    let rating: Int
}
