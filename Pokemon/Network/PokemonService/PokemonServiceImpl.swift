//
//  PokemonServiceImpl.swift
//  Pokemon
//
//  Created by Adjogbe  Tejiri on 14/07/2024.
//

public class PokemonServiceImpl: PokemonService {
    let client = HttpClient.shared
    
    public init() {}
    
    func getpokemons(completion: @escaping (Result<PokemonResponse, ErrorResponse>) -> Void) {
        client.fetchData(url: "https://pokeapi.co/api/v2/pokemon?limit=150") {
            completion($0)
        }
    }
    
    func getDetail(id: Int, completion: @escaping (Result<PokemonDetailResponse, ErrorResponse>) -> Void) {
        client.fetchData(url: "https://pokeapi.co/api/v2/pokemon/\(id)/") {
            completion($0)
        }
    }
}
