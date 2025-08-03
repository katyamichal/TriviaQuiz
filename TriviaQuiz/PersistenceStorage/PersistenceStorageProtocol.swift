//
//  PersistenceStorageProtocol.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import Foundation
import CoreData

// реализовать чтобы не было зависимости от типов данных
protocol PersistenceStorageProtocol: AnyObject {
    associatedtype T: Entity
    func add(_ object: T)
    func fetchAllHistoryResult(type: EntityType, completion: @escaping (Result<[T], Error>) -> Void)
    func deleteResult(with id: Int)
}


protocol Entity {
    var typeName: EntityType { get }
}

enum EntityType: Codable {
    case quizResult
    
    var description: String {
        switch self {
        case .quizResult: return "TriviaQuizResult"
        }
    }
}

