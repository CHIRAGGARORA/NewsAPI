//
//  RetryView.swift
//  NewsAPI
//
//  Created by chirag arora on 13/11/24.
//

import SwiftUI

struct RetryView: View {
    
    let text: String
    let retryAction: () -> ()
    
    var body: some View {
        VStack(spacing: 8) {
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
            
            Button(action: retryAction) {
                Text("Try Again")
            }
        }
    }
}

#Preview {
    RetryView(text: "An error Occured") {
        
    }
}
