//
//  ExceptionHandler.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 01/05/2025.
//

import Foundation

enum ExceptionHandler: Error, CustomStringConvertible, Equatable {
    case networkError(NetworkError)
    case taskCanceled
    case unknownError
    
    var description: String {
        switch self {
        case .networkError(let error):
            return error.description
        case .taskCanceled:
            return "Task Canceled."
        case .unknownError:
            return "Unkown Error Occured"
        }
    }
}

enum NetworkError: Error, CustomStringConvertible, Equatable {
    case noInternetConnection
    case timeout
    case serverUnavailable
    case unauthorized
    case forbidden
    case notFound
    case badRequest
    case tooManyRequests
    case conflict
    case internalServerError
    case decodingError
    case encodingError
    case unknownStatus(code: Int)
    case serverError(code: Int)
    
    var description: String {
        switch self {
        case .noInternetConnection:
            return "No internet connection. Check your network settings."
        case .timeout:
            return "The request timed out. Please try again."
        case .serverUnavailable:
            return "The server is currently unavailable. Please try again later."
        case .unauthorized:
            return "Unauthorized request. Please check your credentials."
        case .forbidden:
            return "Access to the requested resource is forbidden."
        case .notFound:
            return "The requested resource was not found."
        case .badRequest:
            return "The request was malformed or invalid."
        case .tooManyRequests:
            return "Too many requests were made. Please try again later."
        case .conflict:
            return "A conflict occurred with the current state of the resource."
        case .internalServerError:
            return "An internal server error occurred. Please try again later."
        case .decodingError:
            return "Failed to decode data."
        case .encodingError:
            return "Failed to encode data."
        case .unknownStatus(let code):
            return "An unknown error occurred (status code: \(code))."
        case .serverError(let code):
            return "A server error occurred. Please try again later. (status code: \(code))."
        }
    }
}
