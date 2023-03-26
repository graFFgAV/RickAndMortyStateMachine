//
//  LocationService.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 26.03.2023.
//

import Combine

final class LocationService: ObservableObject {
    init(network: RMNetwork) {
        self.network = network
    }

    func getLocations() -> AnyPublisher<RMResult<LocationsResponse>, Never> {
        (network.request(from: RMEndpoint.getLocations())
        as AnyPublisher<RMResult<LocationsResponse>, Never>)
    }
    
    func fetchLocations(page: String) -> AnyPublisher<RMResult<LocationsResponse>, Never> {
        (network.request(from: RMEndpoint.getLocations(page: page))
        as AnyPublisher<RMResult<LocationsResponse>, Never>)
    }
    
    private let network: RMNetwork
}
