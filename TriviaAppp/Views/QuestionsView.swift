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
    @State private var props: CardProps = CardProps()
    @State private var selectedOption = ""
    let category: String
    let data = Question.stubs
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ProgressView(value: Double(props.currentIndex), total: Double(data.count))
                    .progressViewStyle(.linear)
                    .tint(.primary)
                    .scaleEffect(x: 1, y: 1.5, anchor: .center)
                    .padding()
                ZStack {
                    Rectangle()
                        .fill(Color.accentColor.opacity(0.5))
                        .ignoresSafeArea(.all)
                    
                    ForEach(data.indices.reversed(), id: \.self) { index in
                        let relativeIndex = data.distance(from: props.currentIndex, to: index)
                        if relativeIndex >= 0 && relativeIndex < props.maxCardsToDisplay {
                            card(index: index, geo: geo, rIndex: relativeIndex)
                        }
                    }
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Text("Skip")
                            .font(.primary)
                            .foregroundColor(Color(uiColor: .white))
                    }
                    
                }
                ToolbarItem(placement: .principal) {
                    Text("\(props.currentIndex) of \(data.count)")
                        .font(.primary)
                        .foregroundColor(Color(uiColor: .white))
                }
            }
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
                        QuestionItem(question: data[index], selectedOption: $selectedOption)
                        actionButtonView(index: index)
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
    private func actionButtonView (index: Int) -> some View {
        HStack {
            Button {
                guard props.currentIndex > 0 else { return }
                withAnimation(Animation.easeOut(duration: 0.35)) {
                    props.currentIndex = data.index(before: index)
                    props.isBackTracking = true
                    selectedOption = ""
                }
            } label: {
                Text("Back")
                    .foregroundColor(.black)
                    .font(.title2)
                    .frame(width: 120, height: 65)
                    .bold()
            }
            Spacer()
            Button {
                withAnimation(Animation.easeIn(duration: 0.35)) {
                    props.isBackTracking = false
                    props.hasReachedEnd = index == data.count - 1
                    props.currentIndex = data.index(after: index)
                    selectedOption = ""
                }
            } label: {
                Text("Next")
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
                    .frame(width: 120, height: 65)
                    .background(Color.accentColor)
                    .cornerRadius(12)
            }
        }
        .padding(.top, 40)
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
        QuestionsView(category: "music")
    }
}
