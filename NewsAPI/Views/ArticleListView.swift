//
//  ArticleListView.swift
//  NewsAPI
//
//  Created by chirag arora on 12/11/24.
//

import SwiftUI

struct ArticleListView: View {
    
    let articles: [Article]
    @State private var selectedArticle: Article?
    
    var body: some View {
        List {
            ForEach(articles) { article in
                ArticleRowView(article: article)
                    .onTapGesture {
                        selectedArticle = article
                    }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .sheet(item: $selectedArticle) {
            SafariView(url: $0.articleUrl)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel.shared
    
    NavigationView{
        ArticleListView(articles: Article.previewData)
            .environmentObject(articleBookmarkVM)
    }
}
