//
//  QuizViewController.swift
//  TriviaQuiz
//
//  Created by Катя on 01.08.2025.
//

import UIKit
import Combine

class QuizViewController: UIViewController {
    
    private let viewModel: QuizViewModel
    private var quizView: QuizView { return self.view as! QuizView }
    
    private var store = Set<AnyCancellable>()
    
    // MARK: - Inits
    
    init(viewModel: QuizViewModel) {
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
        view = QuizView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension QuizViewController {
    func subscribeLoader() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isShowLoader in
                guard let self else { return }
                self.quizView.updateLoadingView(with: isShowLoader)
            }
            .store(in: &store)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let self else { return }
                self.quizView.showError(with: errorMessage)
            }
            .store(in: &store)
        
        
        viewModel.$currentQuestion
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] question in
                guard let self, let question else { return }
                self.quizView.showQuestion(with: question)
            }
            .store(in: &store)
        
        viewModel.$isNextButtonEnabled
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEnabled in
                self?.quizView.updateNextButton(isEnabled)
                
            }
            .store(in: &store)
        
        viewModel.onShowResult = { [weak self] result in
            self?.quizView.showResultView(with: result)
        }
    }
    
    
    func viewBinding() {
        quizView.onStartQuizButton = { [weak viewModel] in
            viewModel?.loadQuiz()
        }
        
        quizView.onHistoryButton = { [weak self] in
            self?.viewModel.onShowHistory?()
        }
        
        quizView.onOptionTapped = { [unowned self] option in
            viewModel.handleSelectedOption(option)
        }
        
        quizView.onNextQuestion = { [unowned self] in
            viewModel.handleNextQuestion()
        }
    }
}

