//
//  NetworkProviderProtocol.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 01/05/2025.
//

import Foundation

protocol NetworkProviderProtocol {
    func post<T: Codable>(endpoint: any Endpoint, responseType: T.Type) async throws -> T
    func get<T: Codable>(endpoint: any Endpoint, responseType: T.Type) async throws -> T
    func delete<T: Codable>(endpoint: any Endpoint, responseType: T.Type) async throws -> T
    func put<T: Codable>(endpoint: any Endpoint, responseType: T.Type) async throws -> T
}

