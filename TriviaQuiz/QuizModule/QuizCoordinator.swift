//
//  QuizCoordinator.swift
//  TriviaQuiz
//
//  Created by Катя on 01.08.2025.
//

import UIKit
// DI Container, better Swinject though
final class TriviaQuizScreenFactory {
    
    func resoveQuizControllerController() -> QuizViewController {
        let networkService = NetworkService()
        let viewModel = QuizViewModel(
            quizService: networkService)
        let controller = QuizViewController(viewModel: viewModel)
        return controller
    }
    
}


protocol QuizCoordinator: Coordinator {
    
}

final class QuizCoordinatorDefault: QuizCoordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private var window: UIWindow
    private var navigationController: UINavigationController


    init(parentCoordinator: Coordinator? = nil, childCoordinators: [Coordinator] = [], window: UIWindow, navigationController: UINavigationController = UINavigationController()) {
        self.parentCoordinator = parentCoordinator
        self.childCoordinators = childCoordinators
        self.window = window
        self.navigationController = navigationController

    }
    
    func start() {
        let networkService = NetworkService()
        
        let viewModel = QuizViewModel(
            quizService: networkService)
        
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
    
    func removeFromParent() {
        childCoordinators.removeLast()
    }
}
