//
//  LocationsReducer.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 26.03.2023.
//

import Foundation

final class LocationsReducer {
    func reduce(_ state: LocationsViewState, event: LocationsViewEvents) -> LocationsViewState {
        switch state {
        case .start:
            switch event {
            case .onAppear:
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
                return .fetching
            default:
                return state
            }
            
        case .loaded:
            switch event {
            case .onFetch:
                return .fetching
            default:
                return state
            }
            
        case .error:
            switch event {
            case .onAppear:
                return .loading
            default:
                return state
            }
            
        case .fetchError:
            return state
        }
    }
}
