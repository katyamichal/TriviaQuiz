//
//  QuizHistoryCell.swift
//  TriviaQuiz
//
//  Created by Катя on 02.08.2025.
//
import UIKit

// MARK: - Cell

final class QuizHistoryCell: UICollectionViewCell {
    
    var config: Config?
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    let timeLabel = UILabel()
    let ratingImageView = UIImageView()
    
    var topStack = UIStackView()
    var mainStack = UIStackView()
    var bottomStack = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.attributedText = nil
        dateLabel.attributedText = nil
        timeLabel.attributedText = nil
        ratingImageView.image = nil
    }
}

private extension QuizHistoryCell {
    func setupCell() {
        contentView.backgroundColor = .customWhite
        contentView.layer.cornerRadius = 40
        contentView.layer.masksToBounds = true
        setupRatingImageView()
        setupTopStack()
        setupBottomStack()
        setupMainStack()
        setupConstraints()
    }
    
    func setupRatingImageView() {
        ratingImageView.contentMode = .scaleAspectFit
        ratingImageView.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    func setupBottomStack() {
        bottomStack = UIStackView(arrangedSubviews: [dateLabel, UIView(), timeLabel])
        bottomStack.axis = .horizontal
        bottomStack.alignment = .center
        bottomStack.spacing = 8
    }
    
    func setupTopStack() {
        topStack = UIStackView(arrangedSubviews: [nameLabel, ratingImageView])
        topStack.axis = .horizontal
        topStack.alignment = .center
        topStack.spacing = 8
        
    }
    
    func setupMainStack() {
        mainStack = UIStackView(arrangedSubviews: [topStack, bottomStack])
        mainStack.axis = .vertical
        mainStack.spacing = 4
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStack)
    }
    
    func setupConstraints() {
        mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24).isActive = true
    }
}
final class QuizHistoryCellLayout {}
typealias Config = QuizHistoryCellConfig
