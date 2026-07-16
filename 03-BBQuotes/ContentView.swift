//
//  ContentView.swift
//  03-BBQuotes
//
//  Created by sorlenko on 16/07/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Breaking Bad", systemImage: "tortoise") {
                Text("Breaking Bad View")
            }
            
            Tab("Better Call Saul", systemImage: "briefcase") {
                Text("Better Call Saul View")
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
