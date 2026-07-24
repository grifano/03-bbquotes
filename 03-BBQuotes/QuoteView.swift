//
//  QuoteView.swift
//  03-BBQuotes
//
//  Created by sorlenko on 16/07/2026.
//

import SwiftUI

struct QuoteView: View {

    let vm = ViewModel()
    let show: String
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                
                VStack {
                    Text("\"\(vm.quote.quote)\"")
                        .font(.system(size: 20, design: .serif))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(16)
                        .background(.black.opacity(0.7))
                        .clipShape(.rect(cornerRadius: 20))
                        .padding(.horizontal, 20)
                        .frame(maxWidth: geo.size.width)
                        .padding(.bottom, 12)
                    
                    ZStack(alignment: .bottom) {
                        AsyncImage(url: vm.character.images[0]) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: geo.size.width / 1.4, height: geo.size.height / 2)
                        
                        Text(vm.character.name)
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(.ultraThinMaterial)
                    }
                    .frame(width: geo.size.width / 1.4, height: geo.size.height / 2)
                    .clipShape(.rect(cornerRadius: 20))
                    
                    Button {
                        print("pressed...")
                    } label: {
                        Text("Get a quote")
                            .buttonStyle(.glassProminent)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 20)
                            .frame(width: geo.size.width / 1.1)
                            .background(.brown.opacity(0.9))
                            .foregroundStyle(.white)
                            .font(.system(size: 20, weight: .semibold))
                            .clipShape(.capsule)
                            .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
                            .shadow(color: Color.black.opacity(0.3), radius: 16, x: 0, y: 2)
                    }
                    .padding(.top, 16)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    QuoteView(show: "Breaking Bad")
}
