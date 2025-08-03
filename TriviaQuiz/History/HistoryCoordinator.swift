//
//  HistoryCoordinator.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import UIKit

protocol HistoryCoordinator: Coordinator {
    
}

final class HistoryCoordinatorDefault: HistoryCoordinator {

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []

    private var navigationController: UINavigationController


    init(parentCoordinator: Coordinator? = nil,
         childCoordinators: [Coordinator] = [], navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
    }
    
    func start() {
        makeHistoryView()
    }
    
    func finish() {
        navigationController.popViewController(animated: true)
        parentCoordinator?.removeFromParent()
    }
    
    func removeFromParent() {
        
    }
}

private extension HistoryCoordinatorDefault {
    func makeHistoryView() {
        let viewModel = HistoryViewModel(service: HistoryService())
        let controller = HistoryViewController(viewModel: viewModel)
        viewModel.onReturnButton = { [weak self] in
            self?.finish()
        }
        navigationController.pushViewController(controller, animated: true)
    }
}
