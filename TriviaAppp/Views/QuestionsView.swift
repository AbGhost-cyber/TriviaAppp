//
//  QuestionsView.swift
//  TriviaAppp
//
//  Created by dremobaba on 2023/2/6.
//

import SwiftUI

struct CardProps {
    var currentIndex: Int = 0
    var isBackTracking: Bool = false
    var hasReachedEnd: Bool = false
    var maxCardsToDisplay = 3
}

struct QuestionsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var props: CardProps = CardProps()
    @StateObject var viewmodel: QuestionViewModel = QuestionViewModel()
    @State private var showStats = false
    let category: String
    let childCategory: String
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {
                    ProgressView(value: Double(props.currentIndex), total: Double(viewmodel.questions.count))
                        .progressViewStyle(.linear)
                        .tint(.accentColor)
                        .scaleEffect(x: 1, y: 1.5, anchor: .center)
                        .padding()
                        .padding(.bottom)
                        .opacity(props.hasReachedEnd ? 0 : 1)
                    ZStack {
                        ForEach(viewmodel.questions.indices.reversed(), id: \.self) { index in
                            let relativeIndex = viewmodel.questions.distance(from: props.currentIndex, to: index)
                            if relativeIndex >= 0 && relativeIndex < props.maxCardsToDisplay {
                                card(index: index, geo: geo, rIndex: relativeIndex)
                            }
                        }
                    }
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem {
                    Button {
                        withAnimation {
                            handleButtonState(isNext: true, index: props.currentIndex)
                        }
                    } label: {
                        Text("Skip")
                            .font(.primary)
                            .foregroundColor(Color(uiColor: .white))
                    }.opacity(props.hasReachedEnd ? 0 : 1)
                    
                }
                ToolbarItem(placement: .principal) {
                    Text("\(props.currentIndex) of \(viewmodel.questions.count)")
                        .font(.primary)
                        .foregroundColor(Color(uiColor: .white))
                        .opacity(props.hasReachedEnd ? 0 : 1)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("\(Image(systemName: "chevron.left")) \(category)")
                            .font(.secondaryRegular2)
                    }

                }
            }
            .overlay {
                if viewmodel.questions.isEmpty && !viewmodel.isLoading {
                    Text("No questions for this category 😑")
                        .font(.primary)
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                } else if viewmodel.isLoading {
                    ProgressView()
                }
                scoreCard
            }
            .onAppear {
                Task {
                    try await viewmodel.fetchQuestions(category: childCategory)
                }
            }
            .sheet(isPresented: $showStats) {
                Statistics(viewmodel: viewmodel)
                    .preferredColorScheme(.dark)
            }
        }
    }
    
    
    @ViewBuilder
    private var scoreCard: some View {
        if props.hasReachedEnd {
            ScoreCard(score: viewmodel.getUserScore(), category: category) { clickType in
                switch clickType {
                case .playAgain :
                    Task { try await viewmodel.playAgain(category: childCategory)}
                    props.currentIndex = 0
                    props.hasReachedEnd = false
                case .viewStatistics:
                    showStats = true
                }
            }
            .animation(.easeIn, value: props.hasReachedEnd)
        }
    }
    
    @ViewBuilder
    private func card(index: Int, geo: GeometryProxy, rIndex: Int) -> some View {
        RoundedRectangle(cornerRadius: 20, style: .circular)
            .fill(getCardColor(rIndex: rIndex))
            .padding()
            .frame(height: geo.size.height / 1.2)
            .overlay {
                if props.currentIndex == index {
                    VStack {
                        QuestionItem(question: viewmodel.questions[index], viewModel: viewmodel)
                        actionButtonView(index: index, geo: geo)
                    }
                    .padding(.horizontal, 35)
                }
            }
            .offset(x: 0, y: CGFloat(rIndex) * 8)
            .scaleEffect(1 - 0.1 * CGFloat(rIndex), anchor: .bottom)
            .transition(.asymmetric(insertion: props.isBackTracking ? .move(edge: .leading) :
                    .identity, removal: .move(edge: .leading)))
    }
    
    @ViewBuilder
    private func actionButtonView (index: Int, geo: GeometryProxy) -> some View {
        HStack {
            Button {
                guard props.currentIndex > 0 else { return }
                withAnimation(Animation.easeOut(duration: 0.35)) {
                    handleButtonState(isNext: false, index: index)
                }
            } label: {
                Text("Back")
                    .foregroundColor(.black)
                    .font(.title2)
                    .frame(width: geo.size.width / 3, height: 65)
                    .bold()
            }
            Spacer()
            Button {
                withAnimation(Animation.easeIn(duration: 0.35)) {
                    handleButtonState(isNext: true, index: index)
                }
            } label: {
                Text("Next")
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
                    .frame(width: geo.size.width / 2, height: 65)
                    .background(Color.accentColor)
                    .cornerRadius(12)
            }
        }
        .padding(.top, 35)
    }
    
   private func handleButtonState(isNext: Bool = false, index: Int) {
        props.isBackTracking = !isNext
        props.hasReachedEnd = index == viewmodel.questions.count - 1
        props.currentIndex = isNext ? viewmodel.questions.index(after: index) : viewmodel.questions.index(before: index)
        if props.currentIndex <= viewmodel.questions.count - 1 {
            let currentScore = viewmodel.userScores.first { score in
                score.question == viewmodel.questions[props.currentIndex].question
            }
            if let currentScore = currentScore {
                viewmodel.currentScore = currentScore
            }
        }
    }
    
    func getCardColor(rIndex: Int) -> Color {
        let color = Color(uiColor: .white)
        if rIndex == 0 {
            return color
        } else if rIndex == 1 {
            return color.opacity(0.5)
        } else {
            return color.opacity(0.3)
        }
    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsView(category: "Music", childCategory: "music")
            .preferredColorScheme(.dark)
    }
}
