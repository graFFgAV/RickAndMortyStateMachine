//
//  CharactersService.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import Foundation
import Combine
import Alamofire

final class CharactersService: ObservableObject {
    @Published private(set) var allCharacters: [AllCharacters] = []
    
    //forFetch
    var charactersListFull = false
    
    init(network: RMNetwork) {
        self.network = network
    }

    func getCharacters() -> AnyPublisher<RMResult<CharactersResponse>, Never> {
        (network.request(from: RMEndpoint.getCharacters())
        as AnyPublisher<RMResult<CharactersResponse>, Never>)
    }
    
    func fetchCharacters(page: String) -> AnyPublisher<Bool, Never> {
        (network.request(from: RMEndpoint.getCharacters(page: page))
        as AnyPublisher<RMResult<CharactersResponse>, Never>)
            .map { [weak self] result in
                guard let self = self else {
                    return false
                }
                switch result {
                case .success(let value):
                    self.allCharacters.append(contentsOf: value.results ?? [])
                    if value.info.pages <= Int(page) ?? 0 {
                        self.charactersListFull = true
                    }
                    return true
                case .failure(let error):
                    self.charactersListFull = true
                    return false
                }
            }
            .eraseToAnyPublisher()
    }
    
    private let network: RMNetwork
}
