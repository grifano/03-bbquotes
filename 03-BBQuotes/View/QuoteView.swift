//
//  QuoteView.swift
//  03-BBQuotes
//
//  Created by sorlenko on 28/07/2026.
//

import SwiftUI

struct QuoteView: View {
    let quote: String
    let character: CharacterModel
    let images: [URL]
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
            VStack {
                Text(quote)
                    .minimumScaleFactor(0.8)
                    .font(.system(size: 18, design: .serif))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(16)
                    .background(.black.opacity(0.7))
                    .clipShape(.rect(cornerRadius: 20))
                    .frame(width: width)
                
                ZStack(alignment: .bottom) {
                    
                    if let image = character.images.randomElement() {
                        AsyncImage(url: image) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            
                        }
                        .frame(width: width, height: height / 1.2)
                    }
                    
                    Text(character.name)
                        .font(.system(size: 18))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(.ultraThinMaterial)
                }
                .frame(width: width, height: height / 1.2)
                .clipShape(.rect(cornerRadius: 20))
            }
        }
}

//#Preview {
//    QuoteView(quote: ViewModel().quote.quote, character: ViewModel().character, image: ViewModel().character.images[0], width: 200, height: 200)
//}
