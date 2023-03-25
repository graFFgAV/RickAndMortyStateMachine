//
//  CharactersViewModel.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import Combine
import SwiftUI

class CharactersViewModel: ObservableObject {
    @Published private(set) var state = CharactersViewState.start
    @Published private(set) var allCharacters: [AllCharacters] = []
    @Published private(set) var isFullList: Bool = false
    @Published private(set) var errorMessage: String = ""
    
    init(characterServcie: CharactersService) {
        self.characterServcie = characterServcie
    }
    
    func handleStateForEvents(_ event: CharactersViewEvents) {
        switch event {
        case .onAppear:
            state = reduce(state, event: .onAppear)
        case .onFetch:
            state = reduce(state, event: .onFetch)
        default:
            state = .start
        }
        print("State: \(state)")
        print("Event: \(event)")
    }

    func fetchCharacters() {
        if currentPage >= 1 {
            currentPage += 1
            characterServcie.fetchCharacters(page: "\(currentPage)")
                .sink { [weak self] result in
                    guard let self else { return }
                    switch result {
                    case .success(let value):
                        self.allCharacters.append(contentsOf: value.results ?? [])
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
    
    func getCharacters() {
        characterServcie.getCharacters()
            .sink { [weak self] reuslt in
                guard let self else { return }
                switch reuslt {
                case .success(let response):
                    self.currentPage = 1
                    self.allCharacters = response.results ?? []
                    self.state = .loaded
                case .failure(let error):
                    self.state = .error
                    self.errorMessage = error.message
                }
            }
            .store(in: &cancellableSet)
    }
    
    deinit {
        print("!!\(#function)")
    }
    
    private var currentPage: Int = 0
    private let characterServcie: CharactersService
    var cancellableSet: Set<AnyCancellable> = []
}
