//
//  NetworkService.swift
//  TriviaQuiz
//
//  Created by Катя on 01.08.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchQuiz(request: QuizRequest) async throws -> [Quiz]
}

final class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    private let baseURL = "https://opentdb.com/api.php"
    
    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchQuiz(request: QuizRequest) async throws -> [Quiz] {
        guard let url = buildURL(with: request) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await session.data(from: url)
        let decoded = try JSONDecoder().decode(QuizResponse.self, from: data)
        return decoded.results
    }
}

private extension NetworkService {
    func buildURL(with request: QuizRequest) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "amount", value: "\(request.amount)"),
            URLQueryItem(name: "type", value: request.type),
            URLQueryItem(name: "category", value: "\(request.category)"),
            URLQueryItem(name: "difficulty", value: request.difficulty)
        ]
        return components?.url
    }
}
