//
//  QuestionItem.swift
//  TriviaAppp
//
//  Created by dremobaba on 2023/2/6.
//

import SwiftUI

struct QuestionItem: View {
    let question: Question
    @State var options: [String] = []
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select an answer")
                .foregroundColor(.gray)
                .font(.secondaryRegular2)
                .padding(.horizontal, 5)
            Text("\(question.question) 🤔")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black)
                .font(.question)
                .minimumScaleFactor(0.2)
                .lineLimit(4)
                .bold()
                .padding(.top, 5)
            optionsView
                .padding(.top, 10)
        }
        .onAppear {
            options = question.options.shuffled()
        }
    }
    
    
    private var optionsView: some View {
        ForEach(options, id: \.self) { option in
            let isSameAnswer = viewModel.currentScore.userOption == option
            let isSameQuestion = viewModel.currentScore.question == question.question
            let isSelected = isSameAnswer && isSameQuestion
            HStack {
                Image(systemName: isSelected ? "checkmark.circle.fill": "circle")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(isSelected ? .white : .gray, .purple)
                    .padding(.leading)
                Text(option)
                    .foregroundColor(.black)
                    .lineLimit(5)
                    .multilineTextAlignment(.leading)
                    .font(.secondaryRegular2)
                Spacer()
            }
            .overlay {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isSelected ? .purple.opacity(0.4) : .clear)
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? .purple : .gray, lineWidth: 1.5)
                }
                .frame(height: 75)
            }
            //.padding([.vertical, .bottom])
            .frame(minHeight: 75)
            .onTapGesture {
                let isCorrect = option == question.correctAnswer
                let score = Score(isCorrect: isCorrect, userOption: option, question: question.question)
                viewModel.updateCurrentScore(score)
            }
        }
    }
}

struct QuestionItem_Previews: PreviewProvider {
    static var previews: some View {
        QuestionItem(question: .stubs[0], viewModel: QuestionViewModel())
    }
}
