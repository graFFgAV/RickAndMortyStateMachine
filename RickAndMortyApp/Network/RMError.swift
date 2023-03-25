//
//  RMError.swift
//  RickAndMortyApp
//
//  Created by Денис Клюев on 25.03.2023.
//

import Foundation

struct RMError: Error, Codable {
    let code: ErrorsCode
    let message: String
    
    init(code: ErrorsCode) {
        self.code = code
        self.message = code.rawValue
    }
    
    init(code: ErrorsCode, message: String?) {
        self.code = code
        self.message = message ?? code.rawValue
    }

    init(message: String) {
        self.code = .unknownError
        self.message = message
    }
}

enum ErrorsCode: String, Codable {
    case serverError = "Ошибка сервера"
    case unknownError = "Неизвестная ошибка"
    case timeOut = "Время ожидания вышло"
    case validationError = "Ошибка валидации данных"
    case networkError = "Возникли проблемы с сетью"
    case requestError = "Ошибка выполнения запроса"
    case userNotFound = "Ошибка авторизации"
    case pageNotFound = "Страница не найдена"
    case requestCodeError = "Ошибка запроса кода"
    case roomNotFound = "Комната не найдена!"
    case forbidden = "FORBIDDEN"
    case internalError = "INTERNAL_ERROR"
    case badRequest = "BAD_REQUEST"
    case badToken =  "UNAUTHORIZED"
    case badRefreshToken =  "WTF?"
    case duplicate = "Duplicate"
    case noMinio = "Invalid Minio Headers"
}
