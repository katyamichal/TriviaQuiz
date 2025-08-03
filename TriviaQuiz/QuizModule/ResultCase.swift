//
//  ResultCase.swift
//  TriviaQuiz
//
//  Created by Катя on 02.08.2025.
//

import Foundation

enum ResultCase: Int {
    case zero = 0, one, two, three, four, five

    static func from(score: Int) -> ResultCase {
        return ResultCase(rawValue: min(score, 5)) ?? .zero
    }

    var title: String {
        switch self {
        case .five: return "Идеально!"
        case .four: return "Почти идеально!"
        case .three: return "Хороший результат!"
        case .two: return "Есть над чем поработать"
        case .one: return "Сложный вопрос?"
        case .zero: return "Бывает и так!"
        }
    }

    func subtitle(for score: Int, total: Int) -> String {
        switch self {
        case .five:
            return "\(score)/\(total) — вы ответили на всё правильно. Это блестящий результат!"
        case .four:
            return "\(score)/\(total) — очень близко к совершенству. Ещё один шаг!"
        case .three:
            return "\(score)/\(total) — вы на верном пути. Продолжайте тренироваться!"
        case .two:
            return "\(score)/\(total) — не расстраивайтесь, попробуйте ещё раз!"
        case .one:
            return "\(score)/\(total) — иногда просто не ваш день. Следующая попытка будет лучше!"
        case .zero:
            return "\(score)/\(total) — не отчаивайтесь. Начните заново и удивите себя!"
        }
    }
}
