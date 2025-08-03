//
//  TriviaQuizResult+CoreDataProperties.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//
//

import Foundation
import CoreData


extension TriviaQuizResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TriviaQuizResult> {
        return NSFetchRequest<TriviaQuizResult>(entityName: "TriviaQuizResult")
    }

    @NSManaged public var quizIdentifier: String
    @NSManaged public var passDate: Date
    @NSManaged public var rating: Int32

}

extension TriviaQuizResult : Identifiable {

}
