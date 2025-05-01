//
//  NetworkProvider.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 01/05/2025.
//

import Foundation
import Alamofire

class NetworkProvider: NetworkProviderProtocol {
    // MARK: - Standard API Requests
    
    func get<T: Codable>(endpoint: Endpoint, responseType: T.Type) async throws -> T {
        try await sendRequest(endpoint: endpoint, method: .get, responseType: responseType)
    }
    
    func post<T: Codable>(endpoint: Endpoint, responseType: T.Type) async throws -> T {
        try await sendRequest(endpoint: endpoint, method: .post, responseType: responseType)
    }
    
    func put<T: Codable>(endpoint: Endpoint, responseType: T.Type) async throws -> T {
        try await sendRequest(endpoint: endpoint, method: .put, responseType: responseType)
    }
    
    func delete<T: Codable>(endpoint: Endpoint, responseType: T.Type) async throws -> T {
        try await sendRequest(endpoint: endpoint, method: .delete, responseType: responseType)
    }
    
    // MARK: - Handle API Request
    
    private func sendRequest<T: Codable>(
        endpoint: Endpoint,
        method: HTTPMethod,
        responseType: T.Type
    ) async throws -> T {
        
        var urlString = endpoint.mainURL + endpoint.path
        if let queryParameters = endpoint.parameters, !queryParameters.isEmpty {
            var components = URLComponents(string: urlString)
            components?.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            if let urlWithQuery = components?.url?.absoluteString {
                urlString = urlWithQuery
            }
        }
        
        let url = endpoint.mainURL + endpoint.path
        let headers = HTTPHeaders(endpoint.headers ?? [:])
        
        var request = AF.request(url, method: method, headers: headers)
        
        if let body = endpoint.body {
            do {
                let bodyData = try JSONSerialization.data(withJSONObject: body, options: [])
                var urlRequest = try URLRequest(url: url, method: method, headers: headers)
                urlRequest.httpBody = bodyData
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request = AF.request(urlRequest)
            } catch {
                throw error
            }
        }
        
        debugPrintRequest(request: request, body: endpoint.body)
        
        let response = try await request.serializingDecodable(responseType).value
        
        debugPrintResponse(response)
        
        return response
    }
    
    // MARK: - Debugging Functions
    
    private func debugPrintRequest(request: DataRequest, body: Any?) {
#if DEBUG
        do {
            let urlRequest = try request.convertible.asURLRequest()
            print("\n🚀 Request Sent 🚀")
            print("URL: \(urlRequest.url?.absoluteString ?? "Invalid URL")")
            
            if let bodyData = body {
                print("Body Data: \(bodyData)")
            } else {
                print("No body data.")
            }
            
            print("Headers: \(urlRequest.allHTTPHeaderFields ?? [:])")
        } catch {
            print("Error preparing URL request: \(error.localizedDescription)")
        }
#endif
    }
    
    private func debugPrintResponse<T: Codable>(_ response: T) {
#if DEBUG
        print("\n✅ Response Received ✅")
        do {
            let jsonData = try JSONEncoder().encode(response)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Response Data:\n\(jsonString)")
            }
        } catch {
            print("Failed to parse response data.")
        }
#endif
    }
}
