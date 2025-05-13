//
//  EndPoint.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 01/05/2025.
//

import Foundation

protocol Endpoint {
    var mainURL: String { get }
    var parameters: [String: Any]? { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var body: Any? { get }
}

extension Endpoint {
    var mainURL: String {
        return AppConstants.mainURL
    }
    
    var headers: [String: String]? {
        var headers: [String:String] = [:]
        
        headers["Content-Type"] = "application/json"
        headers["x-rapidapi-host"] = "tasty.p.rapidapi.com"
        headers["x-rapidapi-key"] = AppConstants.apiKey
        return headers
    }
}
