//
//  Exten+UIImageView.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import UIKit
extension UIImageView {
    static var logo: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}
