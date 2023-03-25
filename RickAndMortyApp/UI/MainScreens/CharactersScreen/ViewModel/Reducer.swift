//
//  Reducer.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import Foundation

extension CharactersViewModel {
    func reduce(_ state: State, event: Events) -> State {
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
            case .onLoaded(let array):
                return .loaded(array)
            case .onFailurToloaded(let rmError):
                return .error(rmError)
            default:
                return state
            }
            
        case .fetching:
            switch event {
            case .onFetchLoaded(let array):
                return .loaded(array)
            case .onFailurToFetch(let rmError):
                return .fetchError(rmError)
            default:
                return state
            }
            
        case .loaded:
            return state
            
        case .error:
            return state
            
        case .fetchError:
            return state
        }
    }
}
