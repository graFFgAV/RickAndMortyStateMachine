//
//  CharactersViewModel.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import Combine
import SwiftUI

class CharactersViewModel: ObservableObject {
    @Published private(set) var state = State.start
    
    enum State {
        case start
        case loading
        case fetching
        case loaded([AllCharacters])
        case error(RMError)
        case fetchError(RMError)
    }
    
    enum Events {
        case onAppear
        case onLoaded([AllCharacters])
        case onFetchLoaded([AllCharacters])
        case onCharacterSelected(Int)
        case onFailurToloaded(RMError)
        case onFailurToFetch(RMError)
    }
    
    init(characterServcie: CharactersService) {
        self.characterServcie = characterServcie
    }
    
    func handleStateForEvents(_ event: Events) {
        switch event {
        case .onAppear:
            state = reduce(state, event: .onAppear)
        default:
            state = .start
        }
    }

    func fetchCharacters() {
        if currentPage >= 1 {
            currentPage += 1
            characterServcie.fetchCharacters(page: "\(currentPage)")
                .sink { isSuccses in
                    if !isSuccses {
                        //TODO: showError
                    }
                }
                .store(in: &cancellableSet)
        }
    }
    
    func getCharacters() {
        characterServcie.getCharacters()
            .sink { [weak self] reuslt in
                guard let self else { return }
                switch reuslt {
                case .success(let response):
                    self.currentPage = 1
                    self.state = .loaded(response.results ?? [])
                case .failure(let error):
                    self.state = .error(error)
                }
            }
            .store(in: &cancellableSet)
    }
    
    private var currentPage: Int = 0
    private let characterServcie: CharactersService
    var cancellableSet: Set<AnyCancellable> = []
}
