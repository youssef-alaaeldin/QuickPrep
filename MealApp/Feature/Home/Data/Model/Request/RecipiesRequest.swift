//
//  RecipiesRequest.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 06/05/2025.
//

import Foundation

struct RecipiesRequest: Endpoint {
    var size: Int
    var tags: String?
    var q: String?
    
    var parameters: [String : Any]? {
        var parameters: [String : Any] = [:]
        
        parameters["from"] = 0
        parameters["size"] = size
        if let tags = tags {
            parameters["tags"] = tags
        }
        if let q = q {
            parameters["q"] = q
        }
        
        return parameters
    }
    
    var path: String {
        "/recipes/list"
    }
    
    var body: Any?
}
