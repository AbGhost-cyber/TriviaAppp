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
    var icon: String {
        switch self {
        case .artLiterature:
            return "text.book.closed.fill"
        case .filmTV:
            return "tv.fill"
        case .foodDrink:
            return "takeoutbag.and.cup.and.straw.fill"
        case .GK:
            return "books.vertical.fill"
        case .Geography:
            return "map.fill"
        case .History:
            return "globe.americas.fill"
        case .Music:
            return "music.note.list"
        case .Science:
            return "brain"
        case .societyCulture:
            return "figure.2.and.child.holdinghands"
        case .sportLeisure:
            return "sportscourt.fill"
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

extension Int {
    var scoreText: String {
        switch self {
        case 0...2:
            return "Great things are done by a series of small things brought together, don't lose hope soldier 🫡"
        case 3...6:
            return "Keep your eyes on the stars, and your feet on the ground, you can do better 🫶🏾"
        case 7:
            return "Don’t be pushed around by the fears in your mind. Be led by the dreams in your heart, good job 🤙🏾"
        case 8...10:
            return "Good. Better. Best. Never let it rest. ’Til your good is better and your better is best, Congrats 😻"
        default :
            return ""
        }
    }
}
extension Color {
    static subscript(name: String) -> Color {
        switch name {
        case "green":
            return Color.green
        case "teal":
            return Color.teal
        case "accent":
            return Color.accentColor
        case "pink":
            return Color.pink
        case "mint":
            return Color.mint
        case "purple":
            return Color.purple
        case "orange":
            return Color.orange
        case "brown":
            return Color.brown
        case "indigo":
            return Color.indigo
        case "cyan":
            return Color.cyan
        default:
            return Color.accentColor
        }
    }
    static var random: Color {
        let colors = ["green", "teal", "accent", "pink", "mint", "purple", "orange", "brown", "indigo", "cyan"]
        if let random = colors.randomElement() {
           return Color[random]
        }
        return Color["accent"]
    }
}
