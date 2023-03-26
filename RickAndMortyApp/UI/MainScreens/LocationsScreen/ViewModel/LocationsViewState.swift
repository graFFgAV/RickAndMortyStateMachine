//
//  LocationsViewState.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 26.03.2023.
//

import Foundation

enum LocationsViewState: Equatable {
    case start
    case loading
    case fetching
    case loaded
    case error
    case fetchError
}
