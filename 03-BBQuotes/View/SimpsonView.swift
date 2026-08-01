//
//  SimpsonView.swift
//  03-BBQuotes
//
//  Created by sorlenko on 16/07/2026.
//

import SwiftUI

struct SimpsonView: View {
    @Environment(\.dismiss) var dismiss
    
    let vm: ViewModel
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
                                ForEach(vm.randomSimpson.images, id: \.self) {characterImageUrl in
                                    AsyncImage(url: characterImageUrl) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .background(.black.opacity(0.6))
                                            .clipShape(.rect(cornerRadius: 20))
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                            .overlay(alignment: .bottom) {
                                Text("\"\(vm.randomSimpson.phrase)\"")
                                    .foregroundStyle(.white)
                                    .padding(.top, 16)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 44)
                                    .multilineTextAlignment(.center)
                                    .background(.black.opacity(0.6))
                                    .clipShape(.rect(cornerRadius: 12))
                            }
                            .tabViewStyle(.page)
                            .frame(width: geo.size.width / 1.4, height: geo.size.height / 1.4)
                            .clipShape(.rect(cornerRadius: 20))
                            .padding(.top, 40)
                        }
                        .scrollIndicators(.hidden)
                        .navigationTitle(vm.randomSimpson.name)
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
                                        .foregroundStyle(.white)
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

//#SimpsonView {
//    CharacterView(vm: ViewModel(), show: Constants.bbName)
//}
