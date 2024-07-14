//
//  PokemonDetailResponse.swift
//  Pokemon
//
//  Created by Adjogbe  Tejiri on 14/07/2024.
//

import Foundation

// MARK: - PokemonDetailResponseDataModel
struct PokemonDetailResponse: Codable {
    let abilities: [Ability]
    let baseExperience: Int
    let cries: Cries
    let forms: [Species]
    let height, id: Int
    let isDefault: Bool
    let locationAreaEncounters: String
    let name: String
    let order: Int
    let species: Species
    let stats: [Stat]
    let types: [TypeElement]
    let weight: Int

    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case cries, forms, height, id
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case name, order, species, stats, types, weight
    }
}

// MARK: - Ability
struct Ability: Codable {
    let ability: Species
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - Species
struct Species: Codable {
    let name: String
    let url: String
}

// MARK: - Cries
struct Cries: Codable {
    let latest, legacy: String
}

// MARK: - Stat
struct Stat: Codable, Identifiable {
    let id = UUID()
    let baseStat, effort: Int
    let stat: Species

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: Species
}
