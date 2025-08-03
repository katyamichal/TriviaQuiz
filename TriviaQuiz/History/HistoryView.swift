////
////  HistoryView.swift
////  TriviaQuiz
////
////  Created by Катя on 02.08.2025.
////
//
import UIKit

final class HistoryView: UIView {
    
    var onStart: (() -> Void)?
    
    override init(frame: CGRect) {
    
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        collectionView.frame = bounds.inset(by: safeAreaInsets)
//    }
    
    // MARK: - UI
    
    private let emptyHistoryView = EmptyHistoryView()
    private let logo: UIImageView = .logo
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: Self.makeLayout())
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsSelection = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(QuizHistoryCell.self, forCellWithReuseIdentifier: QuizHistoryCellConfig.reuseId)
        return collectionView
    }()
        
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.text = "История"
        label.font = UIFont.systemFont(ofSize: 24, weight: .black)
        label.textColor = .customWhite
        label.textAlignment = .center
        return label
    }()
}


extension HistoryView {
    func showError(with message: String) {
        emptyHistoryView.updateMessage(with: message)
        collectionView.isHidden = true
    }
}

private extension HistoryView {
    func setupAction() {
        emptyHistoryView.onStartTap = { [weak self] in
            self?.onStart?()
        }
    }
}

// MARK: - UI Setup

private extension HistoryView {

    func setupView() {
        backgroundColor = .primaryTrivia
        setupCollectionView()
        addSubview(titleLabel)
        addSubview(emptyHistoryView)
        addSubview(logo)
        setupConstraints()
    }

    func setupCollectionView() {
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        emptyHistoryView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40).isActive = true
        emptyHistoryView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        emptyHistoryView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        
        logo.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -76).isActive = true
        logo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor ,constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -41).isActive = true
    }

     static func makeLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(104)
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitems: [item]
            )

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 24
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 26, bottom: 0, trailing: 26)

            return section
        }
    }
}

