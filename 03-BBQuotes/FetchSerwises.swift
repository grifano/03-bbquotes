//
//  FetchSerwises.swift
//  03-BBQuotes
//
//  Created by sorlenko on 19/07/2026.
//

import Foundation

struct FetchSerwises {
    enum FetchError: Error {
        case badResponse
    }
    
    let baseUrl = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> QuoteModel {
        // Build fetch url
        let quotesUrl = baseUrl.appending(path: "quotes/random")
        let fetchUrl = quotesUrl.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let quote = try JSONDecoder().decode(QuoteModel.self, from: data)
        
        return quote
    }
}
