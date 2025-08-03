//
//  Exten+String.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import UIKit

extension String {
    func attributed(
        font: UIFont = .systemFont(ofSize: UIFont.labelFontSize),
        color: UIColor? = nil
    ) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [
            .font: font,
        ]

        if let color {
            attributes[.foregroundColor] = color
        }

        let attributedString = NSAttributedString(string: self, attributes: attributes)
        return attributedString
    }

}
