//
//  NetworkManager.swift
//  Navigation
//
//  Created by Ислам on 30.11.2024.
//

import Foundation

struct NetworkService {
    static func request(url: URL?) {
        guard let url = url else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("No valid response recieved")
                return
            }
            
            guard let data = data else {
                print("No data recieved")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            print("Response headers: \(response.allHeaderFields)")
            
            if let dataString = String(data: data, encoding: .utf8) {
                print("Response data: \(dataString)")
            } else {
                print("Unable to parse response data")
            }
        }
        
        task.resume()
    }
}
