//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by Adjogbe  Tejiri on 14/07/2024.
//

import Foundation
import Combine

class PokemonViewModel: ObservableObject {
    enum Input {
        case fetchPokemons
        case fetchDetails(Int)
    }
    
    enum Output {
        case fetchPokemonsFailed(ErrorResponse)
        case fetchPokemonsSuccess
        case fetchDetailsSuccess(PokemonDetailResponse)
        case fetchDetailsError(ErrorResponse)
    }
    
    @Published var isLoading: Bool = true
    @Published var searchText: String = ""
    
    let service = PokemonServiceImpl()
    let output = PassthroughSubject<Output, Never>()
    let input = PassthroughSubject<Input, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    var pokemons: [Pokemon]?
    var detail: PokemonDetailResponse?
    
    var filteredPokemon: [Pokemon]? {
        return searchText == "" ? pokemons : pokemons?.filter { $0.name.contains(searchText.lowercased()) }
    }
    
    init() {
        input.sink { [weak self] event in
            switch event {
            case .fetchPokemons:
                self?.fetchPokemons()
            case .fetchDetails(let id):
                self?.fetchPokemonDetails(id: id)
            }
        }
        .store(in: &cancellables)
    }
    
    private func fetchPokemons() {
        isLoading = true
        service.getpokemons {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.pokemons = data.results
                    self?.output.send(.fetchPokemonsSuccess)
                case .failure(let error):
                    self?.output.send(.fetchPokemonsFailed(error))
                }
            }
            
        }
    }
    
    private func fetchPokemonDetails(id: Int) {
        isLoading = true
        service.getDetail(id: id) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.detail = data
                    self?.output.send(.fetchDetailsSuccess(data))
                case .failure(let error):
                    self?.output.send(.fetchDetailsError(error))
                }
            }
            
        }
    }
    
}
