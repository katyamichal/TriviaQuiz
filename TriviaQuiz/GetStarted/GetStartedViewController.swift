//
//  GetStartedViewController.swift
//  TriviaQuiz
//
//  Created by Катя on 01.08.2025.
//

import UIKit
import Combine

class GetStartedViewController: UIViewController {
    
    private let viewModel: GetStartedViewModel
    private var getStartedView: GetStartedView { return self.view as! GetStartedView }
    
    private var store = Set<AnyCancellable>()
    
    // MARK: - Inits
    
    init(viewModel: GetStartedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        subscribeLoader()
        viewBinding()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = GetStartedView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension GetStartedViewController {
    func subscribeLoader() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isShowLoader in
                guard let self else { return }
                self.getStartedView.updateLoadingView(with: isShowLoader)
            }
            .store(in: &store)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let self else { return }
                self.getStartedView.showError(with: errorMessage)
            }
            .store(in: &store)
        
        
        viewModel.$currentQuestion
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] question in
                guard let self, let question else { return }
                self.getStartedView.showQuestion(with: question)
            }
            .store(in: &store)
        
        viewModel.$isNextButtonEnabled
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEnabled in
                self?.getStartedView.updateNextButton(isEnabled)
                
            }
            .store(in: &store)
        
        viewModel.onShowResult = { [weak self] result in
            self?.getStartedView.showResultView(with: result)
        }
    }
    
    
    func viewBinding() {
        getStartedView.onStartQuizButtonTapped = { [weak viewModel] in
            viewModel?.loadQuiz()
        }
        
        getStartedView.onOptionTapped = { [unowned self] option in
            viewModel.handleSelectedOption(option)
        }
        
        getStartedView.onNextQuestion = { [unowned self] in
            viewModel.handleNextQuestion()
        }
    }
}

