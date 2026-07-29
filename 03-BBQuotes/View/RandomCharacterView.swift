//
//  RandomCharacterView.swift
//  03-BBQuotes
//
//  Created by sorlenko on 16/07/2026.
//

import SwiftUI

struct RandomCharacterView: View {
    let character: CharacterModel
    let show: String
    let scrollId = 1
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
            ScrollViewReader { proxy in
                ScrollView {
                    TabView {
                        ForEach(character.images, id: \.self) {characterImageUrl in
                            AsyncImage(url: characterImageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                    .tabViewStyle(.page)
                    .frame(width: width, height: height / 1.6)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(character.name)
                            .font(.largeTitle)
                        Text("Born: \(character.birthday)")
                            .font(.headline)
                        Divider()
                        Text("Occupations:")
                            .font(.headline)
                        ForEach(character.occupations, id: \.self) { occupation in
                            Text("• \(occupation)")
                        }
                        Divider()
                        Text("Nicknames:")
                            .font(.headline)
                        if character.aliases.count > 0 {
                            ForEach(character.aliases, id: \.self) { alias in
                                Text("• \(alias)")
                            }
                        }
                        
                        DisclosureGroup("Status (Spoiler allert!): ") {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(character.status)
                                    .font(.system(size: 16))
                                
                                if let death = character.death {
                                    AsyncImage(url: death.image) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(.rect(cornerRadius: 12))
                                            .onAppear {
                                                withAnimation(.easeInOut) {
                                                    proxy.scrollTo(scrollId, anchor: .bottom)
                                                }
                                            }
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    
                                    Text("How:")
                                        .font(.headline)
                                    Text(death.details)
                                        .font(.system(size: 16))
                                    
                                    Text("Last words:")
                                        .font(.headline)
                                    Text("\"\(death.lastWords)\"")
                                        .font(.system(size: 16))
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .font(.headline)
                        .tint(.primary)
                    }
                    .padding(.bottom, 50)
                    .font(.system(size: 16))
                    .id(scrollId)
                    .frame(width: width / 1.1)
                }
                .scrollIndicators(.hidden)
            }
            .presentationDetents([.large])
            .background(.black.opacity(0.8))
            .foregroundStyle(.white)
            .frame(width: width, height: height / 1.4)
            .clipShape(.rect(cornerRadius: 20))
        }
}


//#Preview {
//    RandomCharacterView(character: ViewModel().character, show: Constants.bbName)
//}
