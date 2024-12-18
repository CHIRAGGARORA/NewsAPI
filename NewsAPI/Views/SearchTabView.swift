//
//  SearchTabView.swift
//  NewsAPI
//
//  Created by chirag arora on 19/11/24.
//

import SwiftUI

struct SearchTabView: View {
    
    @StateObject var searchVM = ArticleSearchViewModel.shared
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView)
                
                .navigationTitle("Search")
        }
        .searchable(text: $searchVM.searchQuery) { suggestionsView }
        .onChange(of: searchVM.searchQuery) { newValue in
            if newValue.isEmpty {
                searchVM.phase = .empty
            }
        }
        .onSubmit(of: .search, {
            search()
        })
    }
    
    private var articles: [Article] {
        if case .success(let articles) = searchVM.phase {
            return articles
        } else {
            return []
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch searchVM.phase {
        case .empty:
            if !searchVM.searchQuery.isEmpty {
                ProgressView()
            } else if !searchVM.history.isEmpty {
                SearchHistoryListView(searchVM: searchVM) { newValue in
                    searchVM.searchQuery = newValue
                }
                
            } else {
                EmptyPlaceHolderView(text: "Type your Query to search from NewsAPI", image: Image(systemName: "magnifyingglass"))
            }
            
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceHolderView(text: "No Search results found", image: Image(systemName: "magnifyingglass"))
            
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: search)
            
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var suggestionsView: some View {
        ForEach(["Swift", "apple", "Covid 19", "BTC", "iPhone", "iOS 18", "Trump", "Elon"], id: \.self) { text in
            Button {
                searchVM.searchQuery = text
            } label: {
                Text(text)
            }

        }
    }
    
    private func search() {
        let searchQuery = searchVM.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        if !searchQuery.isEmpty {
            searchVM.addHistory(searchQuery)
        }
        
        Task {
            await searchVM.searchArticle()
        }
    }
    
}

#Preview {
    
    @StateObject var bookmarkVM = ArticleBookmarkViewModel.shared
    
    SearchTabView()
        .environmentObject(bookmarkVM)
}
