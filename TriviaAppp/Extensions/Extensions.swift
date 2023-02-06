//
//  Extensions.swift
//  TriviaAppp
//
//  Created by dremobaba on 2023/2/6.
//

import Foundation
import SwiftUI

extension Categories {
    func getChild() -> String {
        switch self {
        case .artLiterature:
            return "arts_and_literature"
        case .filmTV:
            return "film_and_tv"
        case .foodDrink:
            return "general_knowledge"
        case .GK:
            return "general_knowledge"
        case .Geography:
            return self.rawValue.lowercased()
        case .History:
            return self.rawValue.lowercased()
        case .Music:
            return self.rawValue.lowercased()
        case .Science:
            return self.rawValue.lowercased()
        case .societyCulture:
            return "society_and_culture"
        case .sportLeisure:
            return "sport_and_leisure"
        }
    }
}

extension Question {
    public static var stubs: [Question] {
        let array = Array(repeating: Question(
            category: "culture",
            id: UUID().uuidString,
            correctAnswer: "Powerful Indian King who established a large empire by conquest before converting to Buddhism.",
            incorrectAnswers: [
                "Queen of England from 1558 to her death in 1603. Cemented England as a Protestant country, defeated Spanish Armada.",
                "Explorer, first European to reach India and establish a route for imperialism.",
                "Spiritual Teacher and founder of Buddhism."
            ],
            question: "🤔 Which of the following describes Asoka?"), count: 10)
        return array
    }
}

extension Font {
    public static var primary: Font {
        boldFont(18)
    }
    public static var category: Font {
        boldFont(22)
    }
    public static var question: Font {
        boldFont(24)
    }
    
    public static var secondaryRegular: Font {
        regularFont(15)
    }
    public static var secondaryRegular2: Font {
        regularFont(17)
    }
    private static func boldFont(_ size: CGFloat) -> Font {
        return .custom("ProximaNova-Bold", size: size)
    }
    private static func regularFont(_ size: CGFloat) -> Font {
        return .custom("ProximaNova-Regular", size: size)
    }
}
