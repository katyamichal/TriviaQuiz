//
//  PersistenceStorage.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import Foundation

final class PersistenceStorage {
    static let shared = PersistenceStorage()
    private init() {}
}

extension PersistenceStorage: PersistenceStorageProtocol {
    typealias T = QuizResultCDO

    func add(_ object: QuizResultCDO) {
        let context = PersistantContainerStorage.persistentContainer.viewContext
        
        let result = TriviaQuizResult(context: context)
        result.quizIdentifier = object.id
        result.passDate = object.passDate
        result.rating = Int32(object.rating)
        PersistantContainerStorage.saveContext()
    }

    func fetchAllHistoryResult(type: EntityType, completion: @escaping (Result<[QuizResultCDO], Error>) -> Void) {
        let context = PersistantContainerStorage.persistentContainer.viewContext
        let request = TriviaQuizResult.fetchRequest()
        
        // Добавляем сортировку от новых к старым
        let sortDescriptor = NSSortDescriptor(key: "passDate", ascending: false)
        request.sortDescriptors = [sortDescriptor]

        do {
            let results = try context.fetch(request)
            let products = results.map {
                QuizResultCDO(
                    id: $0.quizIdentifier,
                    passDate: $0.passDate,
                    rating: Int($0.rating)
                )
            }
            completion(.success(products))
        } catch {
            completion(.failure(error))
        }
    }


    func deleteResult(with id: Int) {
        let context = PersistantContainerStorage.persistentContainer.viewContext
        let request = TriviaQuizResult.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)

        do {
            let results = try context.fetch(request)
            results.forEach { context.delete($0) }
            PersistantContainerStorage.saveContext()
        } catch {
            print("Delete error: \(error)")
        }
    }
}
