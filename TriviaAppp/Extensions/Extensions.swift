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

extension Font {
    public static func primaryBold() -> Font {
        return boldFont(18)
    }
    public static var category: Font {
        boldFont(22)
    }
    
    public static var secondaryRegular: Font {
        regularFont(15)
    }
    
    private static func boldFont(_ size: CGFloat) -> Font {
        return .custom("ProximaNova-Bold", size: size)
    }
    private static func regularFont(_ size: CGFloat) -> Font {
        return .custom("ProximaNova-Regular", size: size)
    }
}
