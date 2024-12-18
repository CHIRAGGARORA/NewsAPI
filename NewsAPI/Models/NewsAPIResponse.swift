//
//  NewsAPIResponse.swift
//  NewsAPI
//
//  Created by chirag arora on 10/11/24.
//

import Foundation


struct NewsAPIResponse: Decodable {
    
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
    
    
    
}
