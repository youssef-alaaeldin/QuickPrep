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
}
