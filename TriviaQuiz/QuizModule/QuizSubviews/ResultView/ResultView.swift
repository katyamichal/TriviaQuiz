//
//  ResultView.swift
//  TriviaQuiz
//
//  Created by Катя on 02.08.2025.
//

import UIKit

struct ResultConfig {
    let rating: String
    let commentTitle: String
    let commentSubtitle: String
    let buttonTitle: String
    let ratingImage: UIImage
    
    init(score: Int, total: Int, ratingImage: UIImage) {
          self.rating = "\(score) из 5"
          let resultCase = ResultCase.from(score: score)
          self.commentTitle = resultCase.title
          self.commentSubtitle = resultCase.subtitle(for: score, total: total)
          self.buttonTitle = "начать заново"
          self.ratingImage = ratingImage
      }
}

final class ResultView: UIView {
    
    var onRestart: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Результаты"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .yellowTrivia
        label.textAlignment = .center
        return label
    }()
    
    private lazy var commentTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var commentSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var restartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.customWhite, for: .normal)
        button.backgroundColor = .primaryTrivia
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return button
    }()
    
    private lazy var ratingImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            ratingLabel,
            commentTitleLabel,
            commentSubtitleLabel,
            restartButton
        ])
        
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.clipsToBounds = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    func configure(with model: ResultConfig) {
        ratingLabel.text = model.rating
        commentTitleLabel.text = model.commentTitle
        commentSubtitleLabel.text = model.commentSubtitle
        restartButton.setTitle(model.buttonTitle, for: .normal)
        ratingImage.image = model.ratingImage
    }
}
extension ResultView {
    func setupAction() {
        restartButton.addTarget(self, action: #selector(restartButtonTap), for: .touchUpInside)
    }
    
    @objc func restartButtonTap() {
        onRestart?()
    }
}

// MARK: - UI Setup
private extension ResultView {
    func setupView() {
        backgroundColor = .customWhite
        layer.cornerRadius = 46
        setupSubviews()
        setupLayout()
        setupAction()
    }
    
    func setupSubviews() {
        [titleLabel, ratingImage, mainStackView]
            .forEach { addSubview($0) }
    }
    
    func setupLayout() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        ratingImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32).isActive = true
        ratingImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        mainStackView.topAnchor.constraint(equalTo: ratingImage.bottomAnchor, constant: 32).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32).isActive = true
    }
}
