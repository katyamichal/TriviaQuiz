//
//  QuestionView.swift
//  TriviaQuiz
//
//  Created by Катя on 01.08.2025.
//

import UIKit

struct QuizViewConfig {
    
}

final class QuestionView: UIView {
    
    var onOptionSelected: ((String) -> Void)?
    var onNextQuestion: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupNextButtonAction()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    
    private lazy var mainStack = UIStackView()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGray
        return label
    }()

    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var optionsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Далее", for: .normal)
        button.backgroundColor = .greyTrivia
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()

    
    // MARK: - Rebuild options
    
    func configure(with question: QuizQuestion, isLast: Bool = true) {
        
        titleLabel.text = question.title
        questionLabel.text = question.question

        optionsStack.removeArrangedSubviews()

        for option in question.options {
            let view = OptionView(title: option.title)
            view.isSelected = option.isSelected
            view.updateAppearance()
            view.addTarget(self, action: #selector(optionTapped(_:)), for: .valueChanged)
            view.accessibilityIdentifier = option.id
            optionsStack.addArrangedSubview(view)
        }
        
    }

    func updateButton(_ isEnabled: Bool) {
        if isEnabled {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .primaryTrivia
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .greyTrivia
        }
    }
}

private extension QuestionView {
    func setupNextButtonAction() {
        nextButton.addTarget(self, action: #selector(onNext), for: .touchUpInside)
    }
    
    @objc func onNext() {
        onNextQuestion?()
    }
    
    @objc func optionTapped(_ sender: OptionView) {
        guard let id = sender.accessibilityIdentifier else { return }
        onOptionSelected?(id)
    }
}

private extension QuestionView {
    func setupView() {
        backgroundColor = .customWhite
        layer.cornerRadius = 46
        clipsToBounds = true
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        mainStack = UIStackView(arrangedSubviews: [titleLabel, questionLabel, optionsStack, nextButton])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.spacing = 16
        addSubview(mainStack)
    }
    
    func setupConstraints() {
        mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        mainStack.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -24).isActive = true
    }
}
