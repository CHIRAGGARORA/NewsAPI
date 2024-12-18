//
//  NewsAPIApp.swift
//  NewsAPI
//
//  Created by chirag arora on 07/11/24.
//

import SwiftUI

@main
struct NewsAPIApp: App {
    
    @StateObject var articelBookmarkVM = ArticleBookmarkViewModel.shared
    @AppStorage("onboarding") var needsOnboarding = true
    // @AppStorage will store this property under the key "onboarding" on the device and it will fetch this value from device for each session in future (All under the Hood)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articelBookmarkVM)
                .fullScreenCover(isPresented: $needsOnboarding) {
                    // on Dismiss
                    needsOnboarding = false
                } content: {
                    OnboardingView()
                        .environmentObject(articelBookmarkVM)
                }
        }
    }
}
