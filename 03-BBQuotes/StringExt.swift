//
//  StringExt.swift
//  03-BBQuotes
//
//  Created by sorlenko on 27/07/2026.
//

import Foundation

extension String {
    func removeEmptySpaces() -> String {
        self.replacingOccurrences(of: " ", with: "")
    }
    func removeEmtyAndLoverCase() -> String {
        self.removeEmptySpaces().lowercased()
    }
}
