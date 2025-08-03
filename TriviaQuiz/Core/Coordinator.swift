//
//  Coordinator.swift
//  TriviaQuiz
//
//  Created by Катя on 01.08.2025.
//

import Foundation

public protocol Coordinator {
    func start()
    func removeFromParent()
}

public extension Coordinator {
    func start() {
        fatalError("start() has not been implemented")
    }
}
