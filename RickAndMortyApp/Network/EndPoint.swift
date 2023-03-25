//
//  EndPoint.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import Alamofire
import Foundation

protocol EndPoint {
    var baseURL: URL { get }
    var type: RequestType { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
}

extension EndPoint {
    var type: RequestType {
        get {
            return .json
        }
    }
}

enum RequestType {
    case json
    case multiPart
}
