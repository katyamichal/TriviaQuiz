//
//  QuizHistoryCellConfig.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import UIKit

struct QuizHistoryCellConfig {

    static let reuseId = String(describing: QuizHistoryCellConfig.self)

    let id: String
    let quizName: NSAttributedString
    let dateDay: NSAttributedString
    let time: NSAttributedString
    let ratingImage: UIImage
    
    let layout = QuizHistoryCellLayout()
}

extension QuizHistoryCellConfig: Hashable, Equatable, Identifiable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(quizName)
        hasher.combine(dateDay)
        hasher.combine(time)
        hasher.combine(ratingImage)
    }

    static func == (lhs: QuizHistoryCellConfig, rhs: QuizHistoryCellConfig) -> Bool {
        lhs.id == rhs.id &&
        lhs.quizName == rhs.quizName &&
        lhs.dateDay == rhs.dateDay &&
        lhs.time == rhs.time &&
        lhs.ratingImage == rhs.ratingImage
    }
}

extension QuizHistoryCellConfig: CollectionCellConfig {
    func update(cell: UICollectionViewCell) {
        guard let cell = cell as? QuizHistoryCell else { return }
        cell.nameLabel.attributedText = quizName
        cell.dateLabel.attributedText = dateDay
        cell.timeLabel.attributedText = time
        cell.ratingImageView.image = ratingImage
        cell.config = self
    }

    func height(with size: CGSize) -> CGFloat {
        104
    }
}
