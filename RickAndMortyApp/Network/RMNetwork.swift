//
//  RMNetwork.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import Alamofire
import Combine
import Foundation
import SwiftUI

protocol ErrorHandler {
    func errorEvent<ResultClass: Decodable>(_ error: RMError, _ endPoint: EndPoint) -> AnyPublisher<RMResult<ResultClass>, Never>
}

final class RMNetwork {
    var errorHandler: ErrorHandler?

    init(errorEvent: ErrorHandler? = nil) {
        self.errorHandler = errorEvent
    }

    func request<ResultClass: Decodable>(from endPoint: EndPoint,
                                         timeout: TimeInterval? = nil) -> AnyPublisher<RMResult<ResultClass>, Never> {
        let request = jsonRequest(from: endPoint, timeout: timeout)
        return request
            .validate()
            .publishDecodable(type: ResultClass.self, decoder: RMDecoder.main)
            .receive(on: DispatchQueue.global(qos: .userInitiated))
            .map({ [weak self] response -> RMResult<ResultClass> in
                guard let self = self else {
                    return RMResult<ResultClass>.failure(RMError(code: .unknownError))
                }
                let json = try? JSONSerialization.jsonObject(with: response.data ?? Data(), options: [])
                return self.responseHandler(response, endPoint: endPoint)
            })
            .receive(on: DispatchQueue.main)
            .flatMap({ [weak self] result -> AnyPublisher<RMResult<ResultClass>, Never> in
                switch result {
                case .success(let result):
                    return Just(RMResult<ResultClass>.success(result))
                        .eraseToAnyPublisher()
                case .failure(let error):
                    if let errorHandler = self?.errorHandler {
                        return errorHandler.errorEvent(error, endPoint) as AnyPublisher<RMResult<ResultClass>, Never>
                    } else {
                        return Just(RMResult<ResultClass>.failure(error))
                            .eraseToAnyPublisher()
                    }
                }
            })
            .eraseToAnyPublisher()
    }
    
    private func responseHandler<T>(_ response: DataResponsePublisher<T>.Output, endPoint: EndPoint) -> RMResult<T> {
        switch response.result {
        case .success(let result):
            return RMResult<T>.success(result)
        case .failure(let error):
            print("ErrorRequest: \(error)")
            return RMResult<T>.failure(RMError(message: "\(error)"))
        }
    }

    private func jsonRequest(from endPoint: EndPoint,
                             timeout: TimeInterval? = nil) -> DataRequest {
        AF.request(endPoint.baseURL,
                   method: endPoint.method,
                   parameters: endPoint.parameters,
                   encoding: JSONEncoding.default,
                   headers: endPoint.headers) { request in
            if let timeout = timeout {
                request.timeoutInterval = timeout
            }
        }
    }

    static func getErrorCode(by statusCode: Int?) -> ErrorsCode {
        let code = statusCode ?? 0
        switch code {
        case 0:
            return ErrorsCode.networkError
        case 1..<299:
            return ErrorsCode.networkError
        case 400:
            return ErrorsCode.validationError
        case 401:
            return ErrorsCode.userNotFound
        case 403:
            return ErrorsCode.forbidden
        case 404:
            return ErrorsCode.pageNotFound
        case 408:
            return ErrorsCode.timeOut
        case 500..<599:
            return ErrorsCode.serverError
        default:
            return ErrorsCode.unknownError
        }
    }
}

enum RMResult<ResultClass> {
    case success(ResultClass)
    case failure(RMError)
}

extension RMResult {
    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
}

struct EmptyResult: Decodable {
}
