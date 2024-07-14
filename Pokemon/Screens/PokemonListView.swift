//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Adjogbe  Tejiri on 14/07/2024.
//

import SwiftUI

struct PokemonListView: View {
    @State var compactMode = UIDevice.current.userInterfaceIdiom == .pad ? true : UIDevice.current.orientation.isLandscape
    @State private var filterText: String = ""
    @StateObject private var vm = PokemonViewModel()
    
    var body: some View {
        NavigationStack {
            if vm.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
            } else {
                VStack {
                    SearchField(text: $vm.searchText, label: "search")
                        .padding(.horizontal, 20)
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                    ScrollView {
                        if let pokemons = vm.filteredPokemon {
                            LazyVGrid(columns:[GridItem(.adaptive(minimum: 200), spacing: 20)], spacing: compactMode ? 65 : 50) {
                                ForEach(0 ..< pokemons.count, id: \.self) { index in
                                    NavigationLink(destination: PokemonDetailView(pokemon: pokemons[index])
                                    ) {
                                        PokemonCard(pokemon: pokemons[index], isCompact: compactMode, index: index)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 60)
                        }
                    }
                    .foregroundStyle(.appBackground)
                    .edgesIgnoringSafeArea(.horizontal)
                    .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            compactMode = true
                        } else {
                            compactMode = scene.interfaceOrientation.isLandscape
                        }
                    }
                    .animation(.easeInOut(duration: 0.3), value: vm.filteredPokemon?.count)
                }
            }
            
        }
        .onReceive(vm.output) { event in
            vm.isLoading = false
        }
        .onAppear {
            vm.input.send(.fetchPokemons)
        }
        .environmentObject(vm)
    }
}

#Preview {
    PokemonListView()
}
