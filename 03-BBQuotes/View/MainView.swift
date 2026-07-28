//
//  MainView.swift
//  03-BBQuotes
//
//  Created by sorlenko on 16/07/2026.
//

import SwiftUI

struct MainView: View {
    
    let vm = ViewModel()
    let show: String
    
    @State var isCharacterViewActive = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.removeEmtyAndLoverCase())
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Spacer(minLength: 100)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                            
                        case .fetching:
                            ProgressView()
                            
                        case .successQuote:
                            Text("\"\(vm.quote.quote)\"")
                                .minimumScaleFactor(0.5)
                                .font(.system(size: 20, design: .serif))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .padding(16)
                                .background(.black.opacity(0.7))
                                .clipShape(.rect(cornerRadius: 20))
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: vm.character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width / 1.2, height: geo.size.height / 2)
                                
                                Text(vm.character.name)
                                    .font(.system(size: 18))
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(12)
                                    .background(.ultraThinMaterial)
                            }
                            .clipShape(.rect(cornerRadius: 20))
                            .onTapGesture {
                                isCharacterViewActive.toggle()
                            }
                            .frame(width: geo.size.width / 1.2, height: geo.size.height / 2)
                            
                        case .successEpisode:
                            EpisodeView(episode: vm.episode)
                            
                        case .failed(let error):
                            Text(error.localizedDescription)
                                .minimumScaleFactor(0.5)
                                .font(.system(size: 20, design: .serif))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .padding(16)
                                .background(.black.opacity(0.7))
                                .clipShape(.rect(cornerRadius: 20))
                                .padding(.horizontal, 20)
                                .frame(maxWidth: geo.size.width)
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Button {
                            Task {
                                await vm.getQuote(for: show)
                            }
                        } label: {
                            Text("Get a Quote")
                                .buttonStyle(.glassProminent)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 24)
                                .background(Color("\(show.removeEmptySpaces())Button").opacity(0.9))
                                .foregroundStyle(.white)
                                .font(.system(size: 18, weight: .semibold))
                                .clipShape(.capsule)
                                .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
                                .shadow(color: Color.black.opacity(0.3), radius: 16, x: 0, y: 2)
                        }
                        
                        Spacer()
                        
                        Button {
                            Task {
                                await vm.getEpisode(for: show)
                            }
                        } label: {
                            Text("Get Episode")
                                .lineLimit(1)
                                .buttonStyle(.glassProminent)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 24)
                                .background(Color("\(show.removeEmptySpaces())Button").opacity(0.9))
                                .foregroundStyle(.white)
                                .font(.system(size: 18, weight: .semibold))
                                .clipShape(.capsule)
                                .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
                                .shadow(color: Color.black.opacity(0.3), radius: 16, x: 0, y: 2)
                        }
                    }
                    
                    Spacer(minLength: 120)
                }
                .padding(.horizontal, 20)
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .blur(radius: isCharacterViewActive ? 4 : 0)
            .overlay {
                if isCharacterViewActive {
                    Rectangle()
                        .opacity(0.5)
                }
            }
        }
        .preferredColorScheme(.dark)
        .ignoresSafeArea()
        .sheet(isPresented: $isCharacterViewActive) {
            CharacterView(character: vm.character, show: show)
        }
    }
}

#Preview {
    MainView(show: Constants.bbName)
}
