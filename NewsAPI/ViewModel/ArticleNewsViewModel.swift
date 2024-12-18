//
//  ArticleNewsViewModel.swift
//  NewsAPI
//
//  Created by chirag arora on 13/11/24.
//

import Foundation
import SwiftUI

enum DataFetchPhase<T> {
    
    case empty
    case success(T)
    case failure(Error)
   
}

struct FetchTaskToken: Equatable {
    var category: Category
    var token: Date
}

@MainActor // Only assigns from MainThread
class ArticleNewsViewModel: ObservableObject {

    // @Published property must always be updated form MainThread to avoid any crashes
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var fetchTaskToken: FetchTaskToken
    
    private let newsAPI = NewsAPI.shared
    
    init(articles: [Article]? = nil, selectedCategory: Category = .general) {
        if let artciles = articles {
            self.phase = .success(articles!)
        } else {
            self.phase = .empty
        }
        self.fetchTaskToken = FetchTaskToken(category: selectedCategory, token: Date())
    }
    
    func loadArticles() async {
        phase = .success(Article.previewData)
        if Task.isCancelled { return }
        phase = .empty
        phase = .success([])
        do {
            let articles = try await newsAPI.fetch(from: fetchTaskToken.category)
            if Task.isCancelled { return }
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            phase  = .failure(error)
        }
        
    }

}
