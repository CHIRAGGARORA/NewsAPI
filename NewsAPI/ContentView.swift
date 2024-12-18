//
//  ContentView.swift
//  NewsAPI
//
//  Created by chirag arora on 07/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsTabView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            SearchTabView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            BookmarkTabView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
            
            
            
        }
        
    }
}

#Preview {
    ContentView()
}
