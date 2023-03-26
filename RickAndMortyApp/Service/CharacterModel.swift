//
//  CharacterModel.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import Foundation

struct CharactersResponse: Codable {
    let info: InfoModel
    let results: [AllCharacters]?
}

struct InfoModel: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct AllCharacters: Codable, Hashable, Identifiable {
    let id: Int
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let image: String?
}

struct LocationsResponse: Codable {
    let info: InfoModel?
    let results: [AllLocations]?
}

struct AllLocations: Codable {
    let id: Int?
    let name: String?
    let type: String?
    let dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
}

struct EpisodesResponse: Codable {
    let info: InfoModel?
    let results: [AllEpisodes]?
}

struct AllEpisodes: Codable {
    let id: Int?
    let name: String?
    let air_date: String?
    let episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
}
