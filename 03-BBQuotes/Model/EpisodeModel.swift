//
//  CharacterModel.swift
//  03-BBQuotes
//
//  Created by sorlenko on 16/07/2026.
//

import Foundation

struct EpisodeModel: Decodable {
    let episode: Int
    let title: String
    let image: URL
    let synopsis: String
    let writtenBy: String
    let directedBy: String
    let airDate: String
    
    var seasonEpisode: String {
        "Season \(episode / 100) Episode \(episode % 100)"
    }
}
