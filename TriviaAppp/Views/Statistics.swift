//
//  Statistics.swift
//  TriviaAppp
//
//  Created by dremobaba on 2023/2/8.
//

import SwiftUI

struct Statistics: View {
    @ObservedObject var viewmodel: QuestionViewModel
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(viewmodel.questions.indices, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 10) {
                        let position = index + 1
                        let question = viewmodel.questions[index].question
                        Text("\(position) \(question)")
                            .font(.category)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("correct answer: ") +
                        Text(viewmodel.questions[index].correctAnswer)
                            .foregroundColor(.green)
                            .font(.secondaryRegular2)
                        Text("your answer: ") +
                        Text(getUserAnswerForQuestion(question))
                            .foregroundColor(isCorrect(question: question) ? .green : .red)
                            .font(.secondaryRegular2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding()
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Statistics")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    private func getUserAnswerForQuestion(_ question: String) -> String {
        if let userIndexForQuestion = viewmodel.userScores.firstIndex(where: {$0.question == question}) {
            return viewmodel.userScores[userIndexForQuestion].userOption
        }
        return "was skipped"
    
    }
    private func isCorrect(question: String) -> Bool {
        if let userIndexForQuestion = viewmodel.userScores.firstIndex(where: {$0.question == question}) {
            return viewmodel.userScores[userIndexForQuestion].isCorrect
        }
        return false
    }
}

struct Statistics_Previews: PreviewProvider {
    static var previews: some View {
        Statistics(viewmodel: QuestionViewModel())
            .preferredColorScheme(.dark)
    }
}
