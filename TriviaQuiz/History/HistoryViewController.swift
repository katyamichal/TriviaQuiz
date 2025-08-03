//
//  HistoryViewController.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import UIKit
import Combine

final class HistoryViewController: UIViewController {

    /// Data Source
    typealias DataSource = UICollectionViewDiffableDataSource<HistoryViewModel.HistorySection, QuizHistoryCellConfig>
    
    private var store = Set<AnyCancellable>()
    
    private lazy var historyView = makeHistoryView()
    private lazy var dataSource = makeDataSource()
    
    private let viewModel: HistoryViewModel

    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        subscribeSnapshot()
        viewBinding()

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = historyView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationAppearance()
        setupRightNavigationButton()
        viewModel.getQuizHistory()
    }
}

// MARK: - Private

 extension HistoryViewController {

     func makeHistoryView() -> HistoryView {
         let view = HistoryView()
         view.collectionView.delegate = viewModel
        return view
    }

    func makeDataSource() -> DataSource {
        DataSource(collectionView: historyView.collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizHistoryCellConfig.reuseId, for: indexPath)
            itemIdentifier.update(cell: cell)
            return cell
        }
    }
     
     func subscribeSnapshot() {
         viewModel.$snapshot
             .dropFirst()
             .receive(on: DispatchQueue.main)
             .sink { [weak self] snapshot in
                 self?.dataSource.apply(snapshot, animatingDifferences: false)
             }
             .store(in: &store)
         
         viewModel.$errorMessage
             .receive(on: DispatchQueue.main)
             .sink { [weak self] errorMessage in
                 guard let errorMessage else { return }
                 self?.historyView.showError(with: errorMessage)
             }
             .store(in: &store)
     }
     
     func viewBinding() {
         historyView.onStart = { [weak self] in
             self?.viewModel.onReturnButton?()
         }
     }
 }

private extension HistoryViewController {
    func setupNavigationAppearance() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        navigationBar.standardAppearance = appearance
        navigationBar.isTranslucent = true
    }
    
    
    func setupRightNavigationButton() {
        let button = UIButton()
        button.setImage(UIImage(named: "left_icon"), for: .normal)
        button.addTarget(self, action: #selector(lefrButtonTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let rightBarButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = rightBarButton
    }
    
    @objc private func lefrButtonTapped() {
        viewModel.onReturnButton?()
    }
}
