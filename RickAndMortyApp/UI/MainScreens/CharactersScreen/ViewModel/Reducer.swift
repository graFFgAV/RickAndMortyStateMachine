//
//  Reducer.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import Foundation

extension CharactersViewModel {
    func reduce(_ state: CharactersViewState, event: CharactersViewEvents) -> CharactersViewState {
        switch state {
        case .start:
            switch event {
            case .onAppear:
                getCharacters()
                return .loading
            default:
                return state
            }
            
        case .loading:
            switch event {
            case .onLoaded:
                return .loaded
            case .onFailurToloaded:
                return .error
            default:
                return state
            }
            
        case .fetching:
            switch event {
            case .onFetchLoaded:
                return .loaded
            case .onFailurToFetch:
                return .fetchError
            case .onFetch:
                fetchCharacters()
                return .fetching
            default:
                return state
            }
            
        case .loaded:
            switch event {
            case .onFetch:
                fetchCharacters()
                return .fetching
            case .onCharacterSelected(let character):
                openDetail = character
                return state
            default:
                return state
            }
            
        case .error:
            switch event {
            case .onAppear:
                getCharacters()
                return .loading
            default:
                return state
            }
            
        case .fetchError:
            return state
        }
    }
}
