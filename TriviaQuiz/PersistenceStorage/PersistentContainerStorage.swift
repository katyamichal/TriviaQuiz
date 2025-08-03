//
//  PersistentContainerStorage.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import CoreData

enum PersistantContainerStorage {
   static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TriviaQuiz")
        container.loadPersistentStores { _, error in
            print("Error to create persistent container: \(String(describing: error))")
        }
        return container
    }()
    
   static func saveContext() {
        let context = PersistantContainerStorage.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Error to save context: \(nserror)")
            }
        }
    }
}
