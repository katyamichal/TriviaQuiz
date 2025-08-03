//
//  HistoryModel.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import Foundation

struct HistoryQuiz: Decodable {
    let id: String
    let quizName: String

    /// Время спрохождения.
    let created: Date
    let rating: Int
}
