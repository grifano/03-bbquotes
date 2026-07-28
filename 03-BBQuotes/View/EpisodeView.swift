//
//  EpisodeView.swift
//  03-BBQuotes
//
//  Created by sorlenko on 28/07/2026.
//

import SwiftUI

struct EpisodeView: View {
    let episode: EpisodeModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(episode.title)
                .font(.largeTitle)
            HStack {
                Text(episode.seasonEpisode)
                    .font(.headline)
                Spacer()
                Text(episode.airDate)
                    .font(.headline)
            }
            
            AsyncImage(url: episode.image) { image in
                VStack(alignment: .leading) {
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 20))
                        .frame(height: 300)
                }
            } placeholder: {
                RoundedRectangle(cornerRadius: 20)
                    .opacity(0.4)
                    .redacted(reason: .placeholder)
                    .frame(height: 300)
            }
            .frame(height: 300)
            
            Text(episode.synopsis)
                .minimumScaleFactor(0.5)
            
            Divider()
            Text("Written By: \(episode.writtenBy)")
            Text("Directed By: \(episode.directedBy)")
            
        }
        .padding()
        .foregroundStyle(.white)
        .background(.black.opacity(0.8))
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    EpisodeView(episode: ViewModel().episode)
}
