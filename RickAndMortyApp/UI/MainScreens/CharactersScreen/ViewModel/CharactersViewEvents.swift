//
//  CharactersViewEvents.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import Foundation

enum CharactersViewEvents {
    case onAppear
    case onFetch
    case onLoaded
    case onFetchLoaded
    case onCharacterSelected(Int)
    case onFailurToloaded
    case onFailurToFetch
}
