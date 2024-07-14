//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Adjogbe  Tejiri on 14/07/2024.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    @EnvironmentObject var vm: PokemonViewModel
    var pokemon: Pokemon
    var body: some View {
        VStack {
            if vm.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
            } else {
                ScrollView {
                    if let detail = vm.detail {
                        VStack(spacing: 20) {
                            VStack {
                                KFImage(URL(string: pokemon.imageUrl)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 130)
                                    .background {
                                        Image("pokeball")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .background(.ultraThinMaterial)
                                    }
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                                Text(pokemon.name)
                                    .font(.title)
                            }
                            .frame(
                                maxWidth: .infinity,
                                minHeight: 300,
                                alignment: .center
                            )
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.grey)
                            }
                            HStack {
                                ForEach(detail.types, id: \.slot) { type in
                                    Text(type.type.name)
                                        .font(.headline)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 5)
                                        .background(Color.colorForType("\(type.type.name)"))
                                        .foregroundColor(.white)
                                        .clipShape(Capsule())
                                }
                            }
                            HStack {
                                InfoView(text: "Weight", image: "scalemass", value: "\(detail.weight) kg")
                                Divider()
                                InfoView(text: "Weight", image: "arrow.up.and.down", value: "\(detail.height) kg")
                                Divider()
                                InfoView(text: "Abilities", image: "bolt.fill", value: detail.abilities.map { $0.ability.name }.joined(separator: "\n"))
                            }
                            .padding()
                            .font(.subheadline)
                            VStack(alignment: .center) {
                                Text("Base Stats")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(Color.colorForType(detail.types.first?.type.name ?? "74CB48"))
                                
                                ForEach(detail.stats, id: \.id) { stat in
                                    StatView(statName: stat.stat.name, value: stat.baseStat, pokeType: detail.types.first?.type.name ?? "74CB48")
                                }
                            }
                            .padding()
                            Spacer()
                        }
                    }
                }
            }
        }
        .ignoresSafeArea(.all)
        .onReceive(vm.output) { event in
            vm.isLoading = false
        }
        .onAppear {
            vm.input.send(.fetchDetails(pokemon.id))
        }
        
    }
}

#Preview {
    PokemonDetailView(pokemon: Pokemon(name: "", url: ""))
        .environmentObject(PokemonViewModel())
}

struct StatView: View {
    var statName: String
    var value: Int
    var pokeType: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(spacing: 7) {
                Text(statName)
                    .fontWeight(.bold)
                    .foregroundColor(Color.colorForType(pokeType))
                ProgressView(value: Double(value), total: 100)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.colorForType(pokeType)))
            }
            
            Text("\(value)")
                .font(.caption)
                .padding(.bottom, -5)
        }
        .padding(.vertical, 4)
    }
}

struct InfoView: View {
    var text: String
    var image: String
    var value: String
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .top) {
                Image(systemName: image)
                    .font(.title2)
                
                Text(value)
            }
            
            Spacer()
            
            Text(text)
                .font(.caption)
                .fontWeight(.light)
        }
    }
}
