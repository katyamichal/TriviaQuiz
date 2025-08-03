//
//  HistoryViewModel.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import UIKit
import Combine

struct HistoryQuiz: Decodable {
    let id: UUID
    let quizName: String

    /// Время спрохождения.
    let created: String
    let rating: Int
}

final class HistoryViewModel: NSObject {
    
    enum HistorySection: Hashable {
        case results
    }
    
   var onReturnButton: (() -> Void)?

    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<HistorySection, QuizHistoryCellConfig>

    @Published private(set) var snapshot: DataSourceSnapshot
    @Published private(set) var errorMessage: String?
    
    private var items = [any CollectionCellConfig & Identifiable]()
    private let ratingRenderer: RatingRenderer


    init(
        snapshot: DataSourceSnapshot = DataSourceSnapshot(),
        ratingRenderer: RatingRenderer = RatingRenderer(config: .small()),
        errorMessage: String? = nil
    ) {
        self.snapshot = snapshot
        self.ratingRenderer = ratingRenderer
        self.errorMessage = errorMessage
        
    }
}

// MARK: - Internal

extension HistoryViewModel {

    func getQuizHistory() {
        // запрос в бд
        let mockData: [HistoryQuiz] = [
            HistoryQuiz(
                id: UUID(),
                quizName: "История Древнего Рима",
                created: "2025-08-01 12:03:00",
                rating: 4
            ),
            HistoryQuiz(
                id: UUID(),
                quizName: "Физика для начинающих",
                created: "2025-08-02 09:45:00",
                rating: 5
            ),
            HistoryQuiz(
                id: UUID(),
                quizName: "Тест по биологии",
                created: "2025-08-03 17:20:00",
                rating: 3
            )
        ]
        
    
        items = mockData.map { makeQuizItem($0) }
        //updateSnapshot()
        errorMessage = "Вы еще не проходили ни одной викторины"
    }
}

// MARK: - Private

private extension HistoryViewModel {

}

// MARK: - UICollectionViewDataSource

extension HistoryViewModel {

    func updateSnapshot() {
        var snapshot = DataSourceSnapshot()
        defer { self.snapshot = snapshot }
        snapshot.appendSections([.results])
        snapshot.appendItems(items as? [QuizHistoryCellConfig] ?? [])
    }

}

// MARK: - Items

private extension HistoryViewModel {

    typealias QuizItem = QuizHistoryCellConfig

    func makeQuizItem(_ quiz: HistoryQuiz) -> QuizHistoryCellConfig {
        let quizNameAttr = quiz.quizName.attributed(font: .quizName)
        
        let date = quiz.created.toDate() ?? Date()
        let dayAttr = date.dayMonthString().attributed(font: .quizDate, color: .black)
        let timeAttr = date.timeString().attributed(font: .quizDate, color: .black)
        
        let ratingImage = ratingRenderer.ratingImage(quiz.rating)
        
        return QuizHistoryCellConfig(
            id: quiz.id,
            quizName: quizNameAttr,
            dateDay: dayAttr,
            time: timeAttr,
            ratingImage: ratingImage
        )
    }
}

// MARK: - UITableViewDelegate

extension HistoryViewModel: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        items[indexPath.row].height(with: collectionView.bounds.size)
    }
}




