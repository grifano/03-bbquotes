//
//  SimpsonModel.swift
//  03-BBQuotes
//
//  Created by sorlenko on 16/07/2026.
//

import Foundation

struct SimpsonModel: Decodable, CombinedCharacter {
    let id: Int
    let name: String
    let portraitPath: String
    let phrases: [String]
    
    var images: [URL] {
        let urlString = "https://cdn.thesimpsonsapi.com/500\(portraitPath)"
        guard let url = URL(string: urlString) else {
            return []
        }
        return [url]
    }
    
    var phrase: String {
        phrases.randomElement() ?? "D'oh!"
    }
}
