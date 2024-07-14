//
//  PokemonService.swift
//  Pokemon
//
//  Created by Adjogbe  Tejiri on 14/07/2024.
//

import Foundation

protocol PokemonService {
    func getpokemons(completion: @escaping (Result<PokemonResponse, ErrorResponse>) -> Void)
    func getDetail(id: Int, completion: @escaping (Result<PokemonDetailResponse, ErrorResponse>) -> Void)
}
