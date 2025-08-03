//
//  Exten+Date.swift
//  TriviaQuiz
//
//  Created by Катя on 03.08.2025.
//

import Foundation


extension String {
    func toDate(format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: self)
    }
}

extension Date {
    func dayMonthString(locale: Locale = Locale(identifier: "ru_RU")) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        formatter.locale = locale
        return formatter.string(from: self)
    }
    
    func timeString(locale: Locale = Locale(identifier: "ru_RU")) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = locale
        return formatter.string(from: self)
    }
}
