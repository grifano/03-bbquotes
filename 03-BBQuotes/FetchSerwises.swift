//
//  FetchSerwises.swift
//  03-BBQuotes
//
//  Created by sorlenko on 19/07/2026.
//

import Foundation

struct FetchSerwises {
    private enum FetchError: Error, LocalizedError {
        case badResponse(String)
        
        var errorDescription: String? {
            switch self {
            case .badResponse(let message):
                    return "\(message) bad response from server"
            }
        }
    }
    
    private let baseUrl = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> QuoteModel {
        // Build fetch url
        let quotesUrl = baseUrl.appending(path: "quotes/random")
        let fetchUrl = quotesUrl.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse("Quotes fetcher: ")
        }
        
        // Decode data
        let quote = try JSONDecoder().decode(QuoteModel.self, from: data)
        
        return quote
    }
    
    func fetchCharacterQuote(from show: String, by character: String) async throws -> QuoteModel {
        // Build fetch url
        let quotesUrl = baseUrl.appending(path: "quotes/random")
        let fetchUrl = quotesUrl.appending(queryItems: [URLQueryItem(name: "character", value: character)])
        
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse("Character Quotes fetcher: ")
        }
        
        // Decode data
        let quote = try JSONDecoder().decode(QuoteModel.self, from: data)
        
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> CharacterModel {
        let characterUrl = baseUrl.appending(path: "characters")
        let fetchUrl = characterUrl.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse("Characters fetcher: ")
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([CharacterModel].self, from: data)
        
        return characters[0]
    }
    
    func fetchRandomCharacter() async throws -> CharacterModel {
        let fetchUrl = baseUrl.appending(path: "characters/random")
        
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse("Random characters fetcher: ")
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let character = try decoder.decode(CharacterModel.self, from: data)
        
        return character
    }
    
    func fetchDeath(for character: String) async throws -> DeathModel? {
        let fetchUrl = baseUrl.appending(path: "deaths")
        
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse("Deaths fetcher: ")
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
    
    func fetchEpisode(_ show: String) async throws -> EpisodeModel? {
        let episodeUrl = baseUrl.appending(path: "episodes")
        let fetchUrl = episodeUrl.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse("Episodes fetcher: ")
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let episodes = try decoder.decode([EpisodeModel].self, from: data)
        
        return episodes.randomElement()
    }
    
    
}
