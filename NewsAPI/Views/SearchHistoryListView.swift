//
//  SearchHistoryListView.swift
//  NewsAPI
//
//  Created by chirag arora on 19/11/24.
//

import SwiftUI

struct SearchHistoryListView: View {
    
    @ObservedObject var searchVM: ArticleSearchViewModel
    let onSubmit: (String) -> ()
    
    var body: some View {
        List {
            HStack {
                Text("Recently Searched")
                Spacer()
                Button("Clear") {
                    searchVM.removeAllHistroy()
                }
                .foregroundStyle(Color.accentColor)
            }
            .listRowSeparator(.hidden)
            
            ForEach(searchVM.history, id: \.self) { history in
                Button(history) {
                    onSubmit(history)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        searchVM.removeHistory(history)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                
            }
            
        }
        .listStyle(.plain)
    }
}

#Preview {
    SearchHistoryListView(searchVM: ArticleSearchViewModel.shared) { _ in
        
        
    }
}
