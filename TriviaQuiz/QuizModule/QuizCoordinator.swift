//
//  QuizCoordinator.swift
//  TriviaQuiz
//
//  Created by Катя on 01.08.2025.
//

import UIKit

protocol QuizCoordinator: Coordinator {}

final class QuizCoordinatorDefault: QuizCoordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private var window: UIWindow
    private var navigationController: UINavigationController
    private let factory: QuizAssembly
    
    
    init(parentCoordinator: Coordinator? = nil,
         childCoordinators: [Coordinator] = [],
         window: UIWindow,
         navigationController: UINavigationController = UINavigationController(),
         factory: QuizAssembly
    ) {
        self.parentCoordinator = parentCoordinator
        self.childCoordinators = childCoordinators
        self.window = window
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        makeView()
    }
    
    func removeFromParent() {
        childCoordinators.removeLast()
    }
}

private extension QuizCoordinatorDefault {
    func makeView() {
        let viewModel = factory.resolveViewModel()
        let controller = QuizViewController(viewModel: viewModel)
        
        viewModel.onShowHistory = { [weak self] in
            self?.showHistory()
        }
        
        navigationController = UINavigationController(rootViewController: controller)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showHistory() {
        let historyCoordinator = HistoryCoordinatorDefault(navigationController: navigationController)
        historyCoordinator.parentCoordinator = self
        childCoordinators.append(historyCoordinator)
        historyCoordinator.start()
    }
}
