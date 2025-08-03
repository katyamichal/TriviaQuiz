//
//  HistoryButton.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import UIKit

final class HistoryButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        textLabel.text = title
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.isUserInteractionEnabled = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
        let image = UIImage(named: "history_icon")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
     
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .primaryTrivia
        return label
    }()

}

// MARK: - UI setup
private extension HistoryButton {
    func setupView() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        self.backgroundColor = .customWhite
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        addSubview(stackView)
        [textLabel,
         iconImageView].forEach( { stackView.addArrangedSubview($0) } )
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 42).isActive = true
        widthAnchor.constraint(greaterThanOrEqualToConstant: 104).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
