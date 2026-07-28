//
//  ViewModel.swift
//  03-BBQuotes
//
//  Created by sorlenko on 20/07/2026.
//

import Foundation

@Observable
@MainActor
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case successQuote
        case successEpisode
        case failed(error: Error)
    }
    
    private(set) var status: FetchStatus = .notStarted
    private(set) var fetcher = FetchSerwises()
    
    var quote: QuoteModel
    var character: CharacterModel
    var episode: EpisodeModel
    
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(QuoteModel.self, from: quoteData)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(CharacterModel.self, from: characterData)
        
        let episodeData = try! Data(contentsOf: Bundle.main.url(forResource: "sampleepisode", withExtension: "json")!)
        episode = try! decoder.decode(EpisodeModel.self, from: episodeData)
        
    }
    
    func getQuote(for show: String) async {
        do {
            status = .fetching
            quote = try await fetcher.fetchQuote(from: show)
            character = try await fetcher.fetchCharacter(quote.character)
            character.death = try await fetcher.fetchDeath(for: character.name)
            status = .successQuote
        } catch {
            status = .failed(error: error)
        }
    }
    
    func getEpisode(for show: String) async {
        status = .fetching
        do {
            if let unwrappedEpisode = try await fetcher.fetchEpisode(show) {
                episode = unwrappedEpisode
            }
            
            status = .successEpisode
        } catch {
            status = .failed(error: error)
        }
    }
}
