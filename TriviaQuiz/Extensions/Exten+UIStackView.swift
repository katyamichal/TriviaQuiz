//
//  Exten+UIStackView.swift
//  TriviaQuiz
//
//  Created by Катя on 02.08.2025.
//

import UIKit

public extension UIStackView {

    func addArrangedSubviews(_ views: UIView...) {
        addArrangedSubviews(views)
    }

    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }

    func removeArrangedSubviews() {
        for subview in self.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
}
