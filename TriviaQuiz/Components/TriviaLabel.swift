//
//  TriviaLabel.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import UIKit

public enum LabelStyle {
    case title
    case subtitle
    case boldTitle
    case smallPrimary
    case description
}

public class TriviaLabel: UILabel {
    // attributed string better
    public init(style: LabelStyle, text: String? = nil) {
        super.init(frame: .zero)
        self.text = text
        self.translatesAutoresizingMaskIntoConstraints = false
        configure(for: style)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(for style: LabelStyle) {
        switch style {
        case .title:
            font = .systemFont(ofSize: 17, weight: .regular)
            textColor = .label
        case .subtitle:
            font = .systemFont(ofSize: 16, weight: .regular)
            textColor = .gray
            numberOfLines = 0
        case .boldTitle:
            font = .boldSystemFont(ofSize: 17)
            textColor = .customWhite
        case .smallPrimary:
            font = .systemFont(ofSize: 12)
            textColor = .primaryTrivia
        case .description:
            font = .monospacedDigitSystemFont(ofSize: 15, weight: .regular)
            textColor = .label
            numberOfLines = 0
        }
    }
}

