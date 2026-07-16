//
//  DeathModel.swift
//  03-BBQuotes
//
//  Created by sorlenko on 16/07/2026.
//

import Foundation

struct DeathModel: Decodable {
    let character: String
    let image: URL
    let details: String
    let lastWords: String
}
