//
//  PokemonResponse.swift
//  Pokemon
//
//  Created by Adjogbe  Tejiri on 14/07/2024.
//

import Foundation

struct PokemonResponse: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Pokemon]?
}

struct Pokemon: Codable {
    let name: String
    let url: String
    var id: Int {
        Int(url.components(separatedBy: "/").dropLast().last ?? "") ?? -1
    }
    var imageUrl: String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}
