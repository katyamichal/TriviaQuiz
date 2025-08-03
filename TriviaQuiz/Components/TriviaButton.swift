//
//  TriviaButton.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//
import UIKit

public enum TriviaButtonState {
    case disabled
    case primary
    case secondary
}

public class TriviaButton: UIButton {
    
    private var style: TriviaButtonState
    // attributed string better
    private var title: String
    // сделать отдельный enum
    private var width: CGFloat
    private var height: CGFloat
    
    
    public init(title: String, style: TriviaButtonState, width: CGFloat, height: CGFloat) {
        self.title = title
        self.style = style
        self.width = width
        self.height = height
        super.init(frame: .zero)
        setupView()
        apply(style)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TriviaButton {
    func apply(_ style: TriviaButtonState) {
        self.style = style
        
        switch style {
        case .disabled:
            backgroundColor = .lightGreyTrivia
            setTitleColor(.customWhite, for: .normal)
            isEnabled = false
            
        case .primary:
            backgroundColor = .primaryTrivia
            setTitleColor(.customWhite, for: .normal)
            isEnabled = true
            
        case .secondary:
            backgroundColor = .customWhite
            setTitleColor(.selection, for: .normal)
            isEnabled = true
        }
    }
}

// MARK: - UI setup

private extension TriviaButton {
    func setupView() {
        let titleAttributed = title.uppercased().attributed(font: .buttonTitle)
        setAttributedTitle(titleAttributed, for: .normal)
        layer.cornerRadius = 16
        clipsToBounds = true
        setupConstraints()
    }

    func setupConstraints() {
       translatesAutoresizingMaskIntoConstraints = false
       heightAnchor.constraint(equalToConstant: height).isActive = true
       widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}
