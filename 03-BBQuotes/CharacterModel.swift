//
//  CharacterModel.swift
//  03-BBQuotes
//
//  Created by sorlenko on 16/07/2026.
//

import Foundation

struct CharacterModel: Decodable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let portrayedBy: String
    let status: DeathModel
}
