//
//  CategoryReqeust.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 12/05/2025.
//

import Foundation

struct CategoryRequest: Endpoint {
    var parameters: [String : Any]?
    
    var path: String {
        "/tags/list"
    }
    
    var body: Any?
}
