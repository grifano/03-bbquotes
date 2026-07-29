//
//  EpisodeView.swift
//  03-BBQuotes
//
//  Created by sorlenko on 28/07/2026.
//

import SwiftUI

struct EpisodeView: View {
    let episode: EpisodeModel
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                AsyncImage(url: episode.image) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: width, height: height / 1.4)
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(episode.title)
                        .font(.largeTitle)
                    Text(episode.seasonEpisode)
                        .font(.headline)
                    
                    Text("Air Date: \(episode.airDate)")
                        .font(.headline)
                    Divider()
                    Text(episode.synopsis)
                        .font(.headline)
                    Divider()
                    Text("Written By: \(episode.writtenBy)")
                        .font(.headline)
                    Text("Directed By: \(episode.directedBy)")
                        .font(.headline)
                }
                .padding(.bottom, 50)
                .font(.system(size: 16))
                .frame(width: width / 1.1)
            }
            .scrollIndicators(.hidden)
        }
        .background(.black.opacity(0.8))
        .foregroundStyle(.white)
        .frame(width: width, height: height)
        .clipShape(.rect(cornerRadius: 20))
    }
}

//#Preview {
//    EpisodeView(episode: ViewModel().episode)
//}
