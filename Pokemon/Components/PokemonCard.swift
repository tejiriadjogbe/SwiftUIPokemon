//
//  PokemonCard.swift
//  Pokemon
//
//  Created by Adjogbe  Tejiri on 14/07/2024.
//

import SwiftUI
import Kingfisher

struct PokemonCard: View {
    var pokemon: Pokemon
    var isCompact: Bool
    var index: Int
    var body: some View {
        let layout = isCompact ? AnyLayout(VStackLayout(alignment: .center, spacing: 20)) : AnyLayout(HStackLayout(spacing: 20))
        layout {
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
            VStack(alignment: .leading) {
                Text(pokemon.name)
                    .font(.title)
            }
        }
        .environment(\.layoutDirection, index % 2 == 0 && !isCompact ? .leftToRight : .rightToLeft)
        .padding(.top, isCompact ? -40 : -15)
        .padding(.bottom, isCompact ? 20 : -15)
        .padding(.horizontal, 20)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: isCompact ? .center : index % 2 == 0 ? .leading : .trailing
        )
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.grey)
        }
    }
}

#Preview {
    PokemonCard(pokemon: Pokemon(name: "", url: ""), isCompact: false, index: 1)
}
