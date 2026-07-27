//
//  CharacterView.swift
//  03-BBQuotes
//
//  Created by sorlenko on 16/07/2026.
//

import SwiftUI

struct CharacterView: View {
    @Environment(\.dismiss) var dismiss
    
    let character: CharacterModel
    let show: String
    let scrollId = 1
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .blur(radius: 6)
            
            NavigationStack {
                ScrollViewReader { proxy in
                    ZStack(alignment: .top) {
                        Image(show.removeEmtyAndLoverCase())
                            .resizable()
                            .scaledToFit()
                        
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
                            .frame(width: geo.size.width / 1.2, height: geo.size.height / 1.9)
                            .clipShape(.rect(cornerRadius: 20))
                            .padding(.top, 40)
                            
                            VStack(alignment: .leading, spacing: 6) {
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
                            .frame(width: geo.size.width / 1.2, alignment: .leading)
                            .id(scrollId)
                        }
                        .scrollIndicators(.hidden)
                        .navigationTitle(character.name)
                        .navigationSubtitle(character.portrayedBy)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button {
                                    dismiss()
                                } label: {
                                    Image(systemName: "xmark")
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button {
                                    dismiss()
                                } label: {
                                    Image(systemName: "checkmark")
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(Color("\(show.removeEmptySpaces())Button"))
                            }
                        }
                        .presentationDetents([.large])
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: Constants.bbName)
}
