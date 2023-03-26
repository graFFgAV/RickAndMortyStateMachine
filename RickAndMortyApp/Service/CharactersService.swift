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
    init(network: RMNetwork) {
        self.network = network
    }

    func getCharacters() -> AnyPublisher<RMResult<CharactersResponse>, Never> {
        (network.request(from: RMEndpoint.getCharacters())
        as AnyPublisher<RMResult<CharactersResponse>, Never>)
    }
    
    func fetchCharacters(page: String) -> AnyPublisher<RMResult<CharactersResponse>, Never> {
        (network.request(from: RMEndpoint.getCharacters(page: page))
        as AnyPublisher<RMResult<CharactersResponse>, Never>)
    }
    
    private let network: RMNetwork
}
