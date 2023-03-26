//
//  CharactersEndpoint.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import Foundation
import Alamofire

enum RMEndpoint: EndPoint {
    case getCharacters(page: String? = nil)
    case getLocations(page: String? = nil)
    case getEpisodes(page: String? = nil)

    var baseURL: URL {
        switch self {
        case .getCharacters(let page):
            var queryItems: [URLQueryItem] = []
            if let page {
                queryItems.append(URLQueryItem(name: "page", value: page))
            }
            let baseUrl = URL(string: "https://rickandmortyapi.com")!
            var components = URLComponents(url: baseUrl,
                                           resolvingAgainstBaseURL: false)
            components?.path = "/api/character"
            components?.queryItems = queryItems
            return (components?.url)!
        case .getLocations(let page):
            var queryItems: [URLQueryItem] = []
            if let page {
                queryItems.append(URLQueryItem(name: "page", value: page))
            }
            let baseUrl = URL(string: "https://rickandmortyapi.com")!
            var components = URLComponents(url: baseUrl,
                                           resolvingAgainstBaseURL: false)
            components?.path = "/api/location"
            components?.queryItems = queryItems
            return (components?.url)!
        case .getEpisodes(let page):
            return URL(string: "https/rickandmortyapi.com/api/agreement?page=\(page)")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }

    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        return nil
    }
}
