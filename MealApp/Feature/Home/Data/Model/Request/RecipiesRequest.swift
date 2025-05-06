//
//  RecipiesRequest.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 06/05/2025.
//

import Foundation

struct RecipiesRequest: Endpoint {
    var size: Int
    var tags: String
    
    var parameters: [String : Any]? {
        var parameters: [String : Any] = [:]
        
        parameters["from"] = 0
        parameters["size"] = size
        parameters["tags"] = tags
                   
        return parameters
    }
    
    var path: String {
        "/list"
    }
    
    var body: Any?
}
