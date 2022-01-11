//
//  APICall.swift
//  du-rush-app
//
//  Created by Dane Koval on 1/7/22.
//

import Foundation

let BASE_ENDPOINT = "http://localhost:3000"

class RushDatabaseCalls {
    
    enum CustomError: Error {
        case invalidURL
        case invalidCredentials
        case invalidDatat
    }
    
    // Use this function to create the request object
    func createReqeust(httpMethod: String, path: String, body: [String: AnyHashable] = [:]) -> URLRequest? {
        guard let url = URL(string: "\(BASE_ENDPOINT)\(path)") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if !body.isEmpty {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        }
        return request
    }
    
    func apiTestCall(completionBlock: @escaping (APITest) -> Void) {
        let request = self.createReqeust(httpMethod: "GET", path: "/api/test")
        let task = URLSession.shared.dataTask(with: request!) { data, _, err in
            
            guard let data = data, err == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(APITest.self, from: data)
                completionBlock(response)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getRequest<T: Codable>(expecting: T.Type, path: String, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: "\(BASE_ENDPOINT)\(path)") else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(CustomError.invalidData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(expecting, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func postRequest<T: Codable>(expecting: T.Type, path: String, body: [String:AnyHashable], completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: "\(BASE_ENDPOINT)\(path)") else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(CustomError.invalidData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(expecting, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
