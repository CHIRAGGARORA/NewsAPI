//
//  OnboardingView.swift
//  NewsAPI
//
//  Created by chirag arora on 19/11/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            
            Color(.black)
            
            VStack {
                
                
                HStack {
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Skip")
                    }

                }
                .padding([.top, .horizontal], 50)
                
                Spacer()
                
                Text("NewsAPI")
                    .font(.largeTitle)
                    .foregroundStyle(.orange)
                
                Spacer()
            }
            
            
            
            
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
}
