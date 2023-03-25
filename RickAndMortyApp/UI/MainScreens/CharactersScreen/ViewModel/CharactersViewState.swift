//
//  State.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import Foundation

enum CharactersViewState: Equatable {
    case start
    case loading
    case fetching
    case loaded
    case error
    case fetchError
}
