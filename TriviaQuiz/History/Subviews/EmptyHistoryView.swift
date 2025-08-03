//
//  EmptyHistoryView.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import UIKit

final class EmptyHistoryView: UIView {
    
    var onStartTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var messageLabel = TriviaLabel(style: .description)
    
    private let startButton = TriviaButton(title: "Начать викторину", style: .primary, width: 280, height: 50)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [messageLabel, startButton])
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
       
        return stackView
    }()
}

extension EmptyHistoryView {
    func updateMessage(with text: String) {
        messageLabel.text = text
    }
}

private extension EmptyHistoryView {
    func setupButtonAction() {
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
    }
    
    @objc func startTapped() {
        onStartTap?()
    }
}
// MARK: - UI setups

private extension EmptyHistoryView {
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        backgroundColor = .customWhite
        layer.cornerRadius = 40
        layer.masksToBounds = true
        setupConstraints()
        setupButtonAction()
    }
    
    func setupConstraints() {
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32).isActive = true
 
    }
}
