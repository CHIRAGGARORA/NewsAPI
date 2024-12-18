//
//  ArticleSearchViewModel.swift
//  NewsAPI
//
//  Created by chirag arora on 19/11/24.
//

import SwiftUI

@MainActor
class ArticleSearchViewModel: ObservableObject {
    
    @Published var phase: DataFetchPhase<[Article]> = .empty
    @Published var searchQuery = ""
    @Published var history = [String]()
    private let historyDataStore = PlistDataStore<[String]>(filename: "histories")
    
    private let historyMaxLimit = 10
    
    private let newsApi = NewsAPI.shared
    
    static let shared = ArticleSearchViewModel()
    
    private init() {
        load()
    }
    
    func addHistory(_ text: String) {
        if let index = history.firstIndex(where: { text.lowercased() == $0.lowercased() }) {
            history.remove(at: index)
        } else if history.count == historyMaxLimit {
            history.remove(at: -1)
        }
        
        history.insert(text, at: 0)
        historiesUpdated()
    }
    
    func removeHistory(_ text: String) {
        guard let index = history.firstIndex(where: { text.lowercased() == $0.lowercased() })
        else {
            return
        }
        history.remove(at: index)
        historiesUpdated()
    }
    
    func removeAllHistroy() {
        history.removeAll()
        historiesUpdated()
    }
    
    func searchArticle() async {
        if Task.isCancelled {
            return
        }
        
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        
        do {
            let articles = try await newsApi.search(for: searchQuery)
            if Task.isCancelled { return }
            if searchQuery != self.searchQuery {
                return
            }
            phase = .success(articles)
            
        } catch {
            if Task.isCancelled { return }
            if searchQuery != self.searchQuery {
                return
            }
            phase = .failure(error)
        }
        
    }
    
    private func load() {
        Task {
            self.history = await historyDataStore.load() ?? []
        }
    }
    
    private func historiesUpdated() {
        let history = self.history
        
        Task {
            await historyDataStore.save(history)
        }
    }
    
}


