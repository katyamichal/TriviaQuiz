//
//  QuizAssembly.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import Foundation


// DI Container, better Swinject though

final class QuizAssembly {
     func resolveViewModel() -> QuizViewModel {
        let networkService = NetworkService()
        let service = QuizService(networkService: networkService)
        let viewModel = QuizViewModel(service: service)
        return viewModel
    }
}
