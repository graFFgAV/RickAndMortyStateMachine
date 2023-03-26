//
//  LocationsViewModel.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 26.03.2023.
//

import Foundation
import Combine

final class LocationsViewModel: ObservableObject {
    @Published private(set) var locations: [AllLocations] = []
    @Published private(set) var state = LocationsViewState.start
    @Published private(set) var isFullList: Bool = false
    @Published private(set) var errorMessage: String = ""
    
    init(locationServcie: LocationService, reducer: LocationsReducer) {
        self.locationServcie = locationServcie
        self.reducer = reducer
    }
    
    func handleStateForEvents(_ event: CharactersViewEvents) {
        print("handleStateForEvents State: \(state) Event: \(event)")
        switch event {
        case .onAppear:
            state = reducer.reduce(state, event: .onAppear)
            getCharacters()
        case .onFetch:
            state = reducer.reduce(state, event: .onFetch)
            fetchCharacters()
        default:
            state = .start
        }
    }

    private func fetchCharacters() {
        if currentPage >= 1 {
            currentPage += 1
            locationServcie.fetchLocations(page: "\(currentPage)")
                .sink { [weak self] result in
                    guard let self else { return }
                    switch result {
                    case .success(let value):
                        self.locations.append(contentsOf: value.results ?? [])
                        self.state = .loaded
                        if value.info.pages <= self.currentPage {
                            self.isFullList = true
                        }
                    case .failure(let error):
                        self.isFullList = true
                        self.state = .error
                        self.errorMessage = error.message
                    }
                }
                .store(in: &cancellableSet)
        }
    }

    private func getCharacters() {
        locationServcie.getLocations()
            .sink { [weak self] reuslt in
                guard let self else { return }
                switch reuslt {
                case .success(let response):
                    self.currentPage = 1
                    self.locations = response.results ?? []
                    self.state = .loaded
                case .failure(let error):
                    self.state = .error
                    self.errorMessage = error.message
                }
            }
            .store(in: &cancellableSet)
    }

    private let reducer: LocationsReducer
    private var currentPage: Int = 0
    private let locationServcie: LocationService
    private var cancellableSet: Set<AnyCancellable> = []
}
