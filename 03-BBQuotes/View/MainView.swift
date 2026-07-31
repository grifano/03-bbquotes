//
//  MainView.swift
//  03-BBQuotes
//
//  Created by sorlenko on 16/07/2026.
//

import SwiftUI

struct MainView: View {
    
    @State var vm = ViewModel()
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
                    Spacer(minLength: 60)
                    
                    VStack(spacing: 8) {
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                            
                        case .fetching:
                            ProgressView()
                                .scaleEffect(2)
                            
                        case .successQuote:
                            QuoteView(quote: vm.quote.quote, character: vm.character, images: vm.character.images, width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                                .onTapGesture {
                                    isCharacterViewActive.toggle()
                                }
                            
                        case .successEpisode:
                            EpisodeView(episode: vm.episode, width: geo.size.width / 1.1, height: geo.size.height / 1.7)
                            
                        case .successCharacter:
                            RandomCharacterView(character: vm.character, show: show, width: geo.size.width / 1.1, height: geo.size.height / 1.2)
                            
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
                    }
                    .frame(width: geo.size.width / 1, height: geo.size.height / 1.6)
                    
                    VStack(spacing: 8) {
                        Button {
                            Task {
                                await vm.getRandomCharacter(from: show)
                            }
                        } label: {
                            Text("Get Character")
                                .frame(maxWidth: .infinity)
                                .buttonStyle(.glassProminent)
                                .padding(.vertical, 14)
                                .padding(.horizontal, 20)
                                .background(Color("\(show.removeEmptySpaces())Button").opacity(0.9))
                                .foregroundStyle(.white)
                                .font(.system(size: 14, weight: .semibold))
                                .clipShape(.capsule)
                                .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
                                .shadow(color: Color.black.opacity(0.3), radius: 16, x: 0, y: 2)
                        }
                        
                        Button {
                            Task {
                                await vm.getQuote(for: show)
                            }
                        } label: {
                            Text("Get Quote")
                                .frame(maxWidth: .infinity)
                                .buttonStyle(.glassProminent)
                                .padding(.vertical, 14)
                                .padding(.horizontal, 20)
                                .background(Color("\(show.removeEmptySpaces())Button").opacity(0.9))
                                .foregroundStyle(.white)
                                .font(.system(size: 14, weight: .semibold))
                                .clipShape(.capsule)
                                .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
                                .shadow(color: Color.black.opacity(0.3), radius: 16, x: 0, y: 2)
                        }
                        
                        Button {
                            Task {
                                await vm.getEpisode(for: show)
                            }
                        } label: {
                            Text("Get Episode")
                                .frame(maxWidth: .infinity)
                                .buttonStyle(.glassProminent)
                                .padding(.vertical, 14)
                                .padding(.horizontal, 20)
                                .background(Color("\(show.removeEmptySpaces())Button").opacity(0.9))
                                .foregroundStyle(.white)
                                .font(.system(size: 14, weight: .semibold))
                                .clipShape(.capsule)
                                .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
                                .shadow(color: Color.black.opacity(0.3), radius: 16, x: 0, y: 2)
                        }
                    }
                    
                    Spacer(minLength: 100)
                }
                .frame(width: geo.size.width / 1.1, height: geo.size.height)
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
            CharacterView(vm: vm, show: show)
        }
        .onAppear() {
                Task {
                    await vm.getQuote(for: show)
                }
        }
    }
}

#Preview {
    MainView(show: Constants.bbName)
}
