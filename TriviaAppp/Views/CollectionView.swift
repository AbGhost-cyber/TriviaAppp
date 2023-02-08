//
//  ContentView.swift
//  TriviaAppp
//
//  Created by dremobaba on 2023/2/6.
//

import SwiftUI

struct CollectionView: View {
    private var gridColumns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridColumns) {
                    ForEach(Categories.allCases, id: \.self) { category in
                        GeometryReader { geo in
                            NavigationLink {
                                QuestionsView(category: category.rawValue, childCategory: category.getChild())
                            } label: {
                                categoryItem(category, size: geo.size.width)
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding()
            }
            .navigationTitle("Trivia App")
        }
    }
    
    private func categoryItem (_ category: Categories, size: Double) -> some View {
            VStack(alignment: .center, spacing: 10) {
                Image(systemName: category.icon)
                    .imageScale(.large)
                    .symbolRenderingMode(.palette)
                    .foregroundColor(Color(uiColor: .white))
                Text(category.rawValue)
                    .foregroundColor(Color(uiColor: .white))
                    .multilineTextAlignment(.center)
                    .font(.primary)
                    .padding(.horizontal)
            }
            .frame(width: size, height: size)
            .background(Color.random)
            .cornerRadius(12)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
            .preferredColorScheme(.dark)
    }
}
