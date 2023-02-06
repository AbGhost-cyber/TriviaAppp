//
//  Models.swift
//  TriviaAppp
//
//  Created by dremobaba on 2023/2/6.
//

import Foundation

enum Categories: String, CaseIterable {
    case artLiterature = "Arts & Literature"
    case filmTV = "Film & TV"
    case foodDrink = "Food & Drink"
    case GK = "General Knowledge"
    case Geography
    case History
    case Music
    case Science
    case societyCulture = "Society & Culture"
    case sportLeisure = "Sport & Leisure"
}

struct Question: Decodable {
    let category: String
    let id: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    let question: String
    
    var options: [String] {
        var answers = [String]()
        answers.append(contentsOf: incorrectAnswers)
        answers.append(correctAnswer)
        answers.shuffle()
        return answers
    }
}
