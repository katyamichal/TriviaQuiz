//
//  HistoryViewModel.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import UIKit
import Combine

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
    private let service: HistoryServiceProtocol

    init(
        service: HistoryServiceProtocol,
        snapshot: DataSourceSnapshot = DataSourceSnapshot(),
        ratingRenderer: RatingRenderer = RatingRenderer(config: .small()),
        errorMessage: String? = nil
    ) {
        self.service = service
        self.snapshot = snapshot
        self.ratingRenderer = ratingRenderer
        self.errorMessage = errorMessage
        
    }
}

// MARK: - Internal

extension HistoryViewModel {
    
    func getQuizHistory() {
        Task { [weak self] in
            guard let self else {
                // проверить отмену
                return
            }
          
            let history = await service.fetchQuizHistory()
            if history.isEmpty {
                self.errorMessage = "Вы еще не проходили ни одной викторины"
            } else {
                self.items = history.map { self.makeQuizItem($0) }
                self.updateSnapshot()
            }
        }
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
    
        let dayAttr = quiz.created.dayMonthString().attributed(font: .quizDate, color: .black)
        let timeAttr = quiz.created.timeString().attributed(font: .quizDate, color: .black)
        
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




