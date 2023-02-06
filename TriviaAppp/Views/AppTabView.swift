//
//  AppTabView.swift
//  TriviaAppp
//
//  Created by dremobaba on 2023/2/6.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            CollectionView()
                .tabItem {
                    Label("Collections", systemImage: "folder.fill")
                }
            VStack {
                
            }.tabItem {
                Label("My History", systemImage: "clock.arrow.circlepath")
            }
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
