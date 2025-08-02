//
//  OptionView.swift
//  TriviaQuiz
//
//  Created by Катя on 02.08.2025.
//

import UIKit

final class OptionView: UIControl {

    private let selectionColor: UIColor
    private let borderColor: UIColor
    private let checkBoxOnImage = UIImage(systemName: "checkmark.circle.fill")
    private let checkBoxOffImage = UIImage(systemName: "circle")
    
    init(
        title: String,
        borderColor: UIColor = .selection,
        selectionColor: UIColor = .selection
    ) {
        self.title.text = title
        self.borderColor = borderColor
        self.selectionColor = selectionColor
        super.init(frame: .zero)
        setupView()
        setupAction()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private lazy var icon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = selectionColor.cgColor
        return view
    }()

    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    func updateAppearance() {
        switch self.isSelected {
            
        case false:
            icon.image = checkBoxOffImage
            icon.tintColor = .blue
            layer.borderWidth = 0
            layer.borderColor = nil
        case true:
            icon.image = checkBoxOnImage
            icon.tintColor = selectionColor
            layer.borderWidth = 1
            layer.borderColor = borderColor.cgColor
            backgroundColor = .customWhite
        }
    }
}
private extension OptionView {
    func setupAction() {
        addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }
    @objc func onTap() {
        sendActions(for: .valueChanged)
    }
}

// MARK: - Private methods

private extension OptionView {
    func setupView() {
        setupViews()
        setupInitialLayout()
        
        layer.cornerRadius = 20
        backgroundColor = .lightGreyTrivia
        
    }
    
    func setupViews() {
        addSubview(icon)
        addSubview(title)
    }

    func setupInitialLayout() {
        icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        icon.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 24).isActive = true

        title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8).isActive = true
        title.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
}
