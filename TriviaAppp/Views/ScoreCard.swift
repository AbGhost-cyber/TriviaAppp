//
//  ScoreCard.swift
//  TriviaAppp
//
//  Created by dremobaba on 2023/2/7.
//

import SwiftUI

struct ScoreCard: View {
    let score: Int
    let category: String
    var action:((ClickType) -> Void)? = nil
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("Quiz Category:  ")
                .font(.primary) +
            Text(category.capitalized)
                .font(.category)
                .foregroundColor(.teal)
            Text(score.scoreText)
                .font(.question)
            Text("You scored ")
                .font(.secondaryRegular2) +
            Text("\(score * 10)%")
                .font(.category)
            VStack(spacing: 15) {
                Button {
                    action?(.viewStatistics)
                } label: {
                    Text("View Statistics")
                        .frame(maxWidth: .infinity, maxHeight: 65)
                        .background(LinearGradient(colors: [.purple, .indigo], startPoint: .leading, endPoint: .bottom))
                        .font(.primary)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                Button {
                    action?(.playAgain)
                } label: {
                    Text("Play Again")
                        .frame(maxWidth: .infinity, maxHeight: 65)
                        .background(Color.accentColor)
                        .font(.primary)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }.padding(.top)
        }
        .padding(30)
    }
}

struct ScoreCard_Previews: PreviewProvider {
    static var previews: some View {
        ScoreCard(score: 6, category: "Society & Culture")
            .preferredColorScheme(.dark)
    }
}

extension ScoreCard {
    enum ClickType {
        case viewStatistics
        case playAgain
    }
}

