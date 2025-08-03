//
//  QuizService.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import CoreData

protocol QuizServiceProtocol {
    func saveQuiz(with rating: Int)
    func loadQuizQuestions() async throws -> [Quiz]
}

final class QuizService: QuizServiceProtocol {
    
    private let storage: PersistenceStorage
    private let networkService: NetworkServiceProtocol
    
    init(
        storage: PersistenceStorage = .shared,
        networkService: NetworkServiceProtocol
    ) {
        self.storage = storage
        self.networkService = networkService
    }
    
    func saveQuiz(with rating: Int) {
        let quizCDO = QuizResultCDO(rating: rating)
        storage.add(quizCDO)
    }
    
    func loadQuizQuestions() async throws -> [Quiz] {
       return try await networkService.fetchQuiz(request: .default)
    }
}
