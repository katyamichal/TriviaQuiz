//
//  HistoryService.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import Foundation

protocol HistoryServiceProtocol {
    func fetchQuizHistory() async -> [HistoryQuiz]
}

final class HistoryService: HistoryServiceProtocol {
    
    private let storage: PersistenceStorage = .shared

    
    func fetchQuizHistory() async -> [HistoryQuiz] {
        await withCheckedContinuation { continuation in
            storage.fetchAllHistoryResult(type: .quizResult) { result in
                switch result {
                case .success(let quizResultsCDO):
                    let history: [HistoryQuiz] = quizResultsCDO.enumerated().map { index, quiz in
                        HistoryQuiz(
                            id: quiz.id,
                            quizName: "Quiz \(index + 1)",
                            created: quiz.passDate,
                            rating: quiz.rating
                        )
                    }
                    continuation.resume(returning: history)
                case .failure(let error):
                    print("Error to fetch quiz history: \(error.localizedDescription)")
                    continuation.resume(returning: [])
                }
            }
        }
    }

}
