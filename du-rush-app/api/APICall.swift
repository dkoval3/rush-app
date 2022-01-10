//
//  APICall.swift
//  du-rush-app
//
//  Created by Dane Koval on 1/7/22.
//

import Foundation

class RushDatabaseCalls {
    // Use this function to create the request object
    func createReqeust(httpMethod: String, path: String, body: [String: AnyHashable] = [:]) -> URLRequest? {
        guard let url = URL(string: "http://localhost:3000\(path)") else { return nil }
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
    
    func getUserCredentials(body: [String:AnyHashable], completionBlock: @escaping ([UserCreds]) -> Void) {
        guard let request = self.createReqeust(httpMethod: "POST", path: "/auth/login", body: body) else { return }
        let task = URLSession.shared.dataTask(with: request) { data, _, err in
            guard let data = data, err == nil else {
                print(err ?? "Error: data is nil")
                return
            }
            
            do {
                let response = try JSONDecoder().decode([UserCreds].self, from: data)
                completionBlock(response)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
