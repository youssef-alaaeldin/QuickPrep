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
        
        let headers = HTTPHeaders(endpoint.headers ?? [:])
        
        var request = AF.request(urlString, method: method, headers: headers)
        
        if let body = endpoint.body {
            do {
                let bodyData = try JSONSerialization.data(withJSONObject: body, options: [])
                var urlRequest = try URLRequest(url: urlString, method: method, headers: headers)
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
            print("\n🚀🚀🚀 [REQUEST] 🚀🚀🚀")
            print("{")
            print("  \"url\": \"\(urlRequest.url?.absoluteString ?? "Invalid URL")\",")
            
            // Print Headers
            let headers = urlRequest.allHTTPHeaderFields ?? [:]
            if !headers.isEmpty {
                print("  \"headers\": \(prettyJSONString(from: headers)) ,")
            } else {
                print("  \"headers\": {},")
            }
            
            // Print Body
            if let body = body {
                if let jsonData = try? JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted]),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("  \"body\": \(jsonString)")
                } else {
                    print("  \"body\": \"Invalid Body Format\"")
                }
            } else {
                print("  \"body\": null")
            }
            
            print("}")
        } catch {
            print("❌ Failed to print request: \(error.localizedDescription)")
        }
#endif
    }
    
    private func debugPrintResponse<T: Codable>(_ response: T) {
#if DEBUG
        print("\n✅✅✅ [RESPONSE] ✅✅✅")
        do {
            let jsonData = try JSONEncoder().encode(response)
            if let object = try? JSONSerialization.jsonObject(with: jsonData, options: []),
               let prettyData = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
               let jsonString = String(data: prettyData, encoding: .utf8) {
                print(jsonString)
            } else {
                print("⚠️ Unable to pretty print response")
            }
        } catch {
            print("❌ Failed to encode response: \(error.localizedDescription)")
        }
#endif
    }
    
    private func prettyJSONString(from object: Any) -> String {
        if let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
           let jsonString = String(data: data, encoding: .utf8) {
            return jsonString
        }
        return "{}"
    }
}
