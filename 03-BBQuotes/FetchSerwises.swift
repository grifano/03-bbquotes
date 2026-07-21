//
//  FetchSerwises.swift
//  03-BBQuotes
//
//  Created by sorlenko on 19/07/2026.
//

import Foundation

struct FetchSerwises {
    private enum FetchError: Error {
        case badResponse
    }
    
    private let baseUrl = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
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
    
    func fetchCharacter(_ name: String) async throws -> CharacterModel {
        let characterUrl = baseUrl.appendingPathExtension("characters")
        let fetchUrl = characterUrl.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([CharacterModel].self, from: data)
        
        return characters[0]
    }
    
    func fetchDeath(for character: String) async throws -> DeathModel? {
        let fetchUrl = baseUrl.appending(path: "death")
        
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([DeathModel].self, from: data)
        
        for death in deaths {
            if death.character == character {
                return death
            }
        }
        
        return nil
    }
}
