//
//  QuizView.swift
//  TriviaQuiz
//
//  Created by Катя on 01.08.2025.
//

import UIKit

final class QuizView: UIView {

    // MARK: - Event Handlers

    var onHistoryButton: (() -> Void)?
    var onStartQuizButton: (() -> Void)?
    var onOptionTapped: ((String) -> Void)?
    var onNextQuestion: (() -> Void)?
    var onRestart: (() -> Void)?

    // MARK: - Initialization

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

    // MARK: - UI Components

    private lazy var messageLabel = TriviaLabel(style: .description)

    private(set) lazy var quizView: QuestionView = {
        let view = QuestionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    private(set) lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = UIColor(named: "customWhite")
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private lazy var historyButton: HistoryButton = {
        let button = HistoryButton(title: "История")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let logo: UIImageView = .logo

    private lazy var startStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 48
        stack.layer.cornerRadius = 16
        stack.backgroundColor = .customWhite
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()

    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.text = "Добро пожаловать в DailyQuiz!"
        label.textAlignment = .center
        return label
    }()

    private lazy var startButton = TriviaButton(title: "Начать викторину", style: .primary, width: 280, height: 50)

    private lazy var resultView: ResultView = {
        let view = ResultView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    private var quizViewTopConstraint: NSLayoutConstraint?
    private var resultViewTopConstraint: NSLayoutConstraint?
}

// MARK: - Public Interface

extension QuizView {
    @objc
    func historyButtonTapped() {
        onHistoryButton?()
    }

    @objc
    func startQuizButtonTapped() {
        onStartQuizButton?()
    }

    func showError(with message: NSAttributedString?) {
        messageLabel.isHidden = false
        messageLabel.attributedText = message
    }

    func showQuestion(with question: QuizQuestion) {
        [startStackView, resultView, historyButton].forEach { $0.isHidden = true }
        quizView.isHidden = false
        logo.isHidden = false

        quizViewTopConstraint?.isActive = false
        quizViewTopConstraint = quizView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32)
        quizViewTopConstraint?.isActive = true

        quizView.configure(with: question)
        quizView.onOptionSelected = { [weak self] in self?.onOptionTapped?($0) }
        quizView.onNextQuestion = { [weak self] in self?.onNextQuestion?() }
    }

    func updateLoadingView(with status: Bool) {
        if status {
            activityIndicator.startAnimating()
            [startStackView, historyButton, resultView, quizView].forEach { $0.isHidden = true }
        } else {
            activityIndicator.stopAnimating()
        }
    }

    func updateNextButton(_ isEnabled: Bool) {
        quizView.updateButton(isEnabled)
    }

    func showResultView(with result: ResultConfig) {
        [startStackView, quizView, historyButton].forEach { $0.isHidden = true }
        logo.isHidden = true
        resultView.isHidden = false

        resultViewTopConstraint?.isActive = false
        resultViewTopConstraint = resultView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32)
        resultViewTopConstraint?.isActive = true

        resultView.configure(with: result)
    }

    func reset() {
        [quizView, resultView].forEach { $0.isHidden = true }
        [startStackView, historyButton].forEach { $0.isHidden = false }
        logo.isHidden = false

        quizViewTopConstraint?.isActive = false
        quizViewTopConstraint = quizView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32)
        quizViewTopConstraint?.isActive = true

        resultViewTopConstraint?.isActive = false
        resultViewTopConstraint = resultView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32)
        resultViewTopConstraint?.isActive = true
    }
}

// MARK: - Setup and Actions

private extension QuizView {
    func setupView() {
        setupSubviews()
        setupConstraints()
        setupButtonActions()
    }

    func setupSubviews() {
        [historyButton, quizView, activityIndicator, logo, startStackView, resultView, messageLabel].forEach(addSubview)
        startStackView.addArrangedSubview(welcomeLabel)
        startStackView.addArrangedSubview(startButton)
    }

    func setupConstraints() {
        quizViewTopConstraint = quizView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32)
        resultViewTopConstraint = resultView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32)
        
        historyButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        historyButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        logo.topAnchor.constraint(equalTo: historyButton.bottomAnchor, constant: 46).isActive = true
        logo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        startStackView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32).isActive = true
        startStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        startStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        startStackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
        
        quizView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        quizView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: startStackView.bottomAnchor, constant: 16).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        resultView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        resultView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        
        
        quizViewTopConstraint?.isActive = true
        resultViewTopConstraint?.isActive = true
    }

    func setupButtonActions() {
        historyButton.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startQuizButtonTapped), for: .touchUpInside)
        resultView.onRestart = { [weak self] in self?.onRestart?() }
    }
}
