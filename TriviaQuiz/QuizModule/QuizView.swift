//
//  QuizView.swift
//  TriviaQuiz
//
//  Created by Катя on 01.08.2025.
//

import UIKit

final class QuizView: UIView {
    
    var onHistoryButton: (() -> Void)?
    var onStartQuizButton: (() -> Void)?
    var onOptionTapped: ((String) -> Void)?
    var onNextQuestion: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .primaryTrivia
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.center = center
    }
    
    // MARK: - UI
    
    // MARK: View с вопросами
    private(set) lazy var quizView: QuestionView = {
        let view = QuestionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    // MARK: Загрузка
  
    private(set) lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = UIColor(named: "customWhite")
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    // MARK:  Стартовое View
    
    private lazy var historyButton: HistoryButton = {
        let button = HistoryButton(title: "История")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let logo: UIImageView = .logo
    
    private lazy var startStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 48
        stackView.layer.cornerRadius = 16
        stackView.backgroundColor = .customWhite
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    // TODO: - сменить на trivia
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.text = "Добро пожаловать в DailyQuiz!"
        label.textAlignment = .center
        return label
    }()
    
    
    private lazy var startButton = TriviaButton(title: "Начать викторину", style: .primary, width: 280, height: 50)
    
    // MARK: Результат View
    
    private lazy var resultView: ResultView = {
        let view = ResultView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
}

extension QuizView {
    func setupButtonActions() {
        historyButton.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startQuizButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func historyButtonTapped() {
        onHistoryButton?()
    }
    
    @objc
    func startQuizButtonTapped() {
        onStartQuizButton?()
    }

    func showError(with message: NSAttributedString?) {
        print(message)
    }
    
    func showQuestion(with question: QuizQuestion) {
        startStackView.isHidden = true
        resultView.isHidden = true
        historyButton.isHidden = true
        quizView.isHidden = false
  
        
        quizView.configure(with: question)
        
        quizView.onOptionSelected = { [weak self] option in
            self?.onOptionTapped?(option)
        }
        
        quizView.onNextQuestion = { [weak self] in
            self?.onNextQuestion?()
        }
    }

    func updateLoadingView(with status: Bool) {
        if status {
            activityIndicator.startAnimating()
            startStackView.isHidden = true
            historyButton.isHidden = true
            resultView.isHidden = true
            quizView.isHidden = true
            historyButton.isHidden = true
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func updateNextButton(_ isEnabled: Bool) {
        quizView.updateButton(isEnabled)
    }
    
    func showResultView(with result: ResultConfig) {
        startStackView.isHidden = true
        quizView.isHidden = true
        logo.isHidden = true
        historyButton.isHidden = true
        resultView.isHidden = false
        resultView.configure(with: result)
    }
}

// MARK: - UI Setups

private extension QuizView {
    func setupView() {
        setupSubviews()
        setupConstraints()
        setupButtonActions()
    }
    
    func setupSubviews() {
        addSubview(historyButton)
        addSubview(quizView)
        addSubview(activityIndicator)
        addSubview(logo)
        addSubview(startStackView)
        addSubview(resultView)

        startStackView.addArrangedSubview(welcomeLabel)
        startStackView.addArrangedSubview(startButton)
    }
    
    
    func setupConstraints() {
        historyButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        historyButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        logo.topAnchor.constraint(equalTo: historyButton.bottomAnchor, constant: 96).isActive = true
        logo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 180).isActive = true
 
        
        startStackView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32).isActive = true
        startStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        startStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        startStackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
        
        
        quizView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32).isActive = true
        quizView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        quizView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        
        
        resultView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32).isActive = true
        resultView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        resultView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
    }
}

