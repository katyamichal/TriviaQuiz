//
//  ResultConfig.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import UIKit

struct ResultConfig {
    let rating: String
    let commentTitle: String
    let commentSubtitle: String
    let buttonTitle: String
    let ratingImage: UIImage
    
    init(score: Int, total: Int, ratingImage: UIImage) {
          self.rating = "\(score) из 5"
          let resultCase = ResultCase.from(score: score)
          self.commentTitle = resultCase.title
          self.commentSubtitle = resultCase.subtitle(for: score, total: total)
          self.buttonTitle = "начать заново"
          self.ratingImage = ratingImage
      }
}
