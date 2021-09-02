//
//  networkManager.swift
//  WantHelp
//
//  Created by Булат on 27.08.2021.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase
import CoreData
import CodableFirebase

class NetworkManager {
    
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    func parseJSONCategoryFromURL(completion: @escaping ((Result<[Category], Error>) -> Void)) {
        
        DispatchQueue.global(qos: .background).async { [self] in
            guard let url = URL(string: "https://networking-56bfe-default-rtdb.firebaseio.com/.json") else { return }
            session.dataTask(with: url) { [self] (data, response, error) in
                print("Data: \(String(describing: data))")
                if error == nil, let parsData = data {
                    let result = try? decoder.decode([Category].self, from: parsData)
                    print(result!)
                    print("Result from URLSession: \(String(describing: result))")
                    DispatchQueue.main.async {
                        completion(.success(result!))
                    }
                }
                else {
                    DispatchQueue.main.async {
                        completion(.failure(error!))
                    }
                    print("Error\(String(describing: error?.localizedDescription))")
                }
            }.resume()
        }
    }
    
    func parseJSONEventFromURL(completion: @escaping ((Result<[Event], Error>) -> Void)){
        DispatchQueue.global(qos: .background).async { [self] in
            guard let url = URL(string: "https://networking-56bfe-default-rtdb.firebaseio.com/.json") else { return }
            session.dataTask(with: url) { [self] (data, response, error) in
                
                if error == nil, let parsData = data {
                    let posts = try? decoder.decode([CategoryRoot].self, from: parsData)
                    let result = posts?[0].events
                    print("Result from URLSession: \(String(describing: result))")
                    DispatchQueue.main.async {
                        completion(.success(result!))
                    }
                }
                else {
                    DispatchQueue.main.async {
                        completion(.failure(error!))
                    }
                    print("Error\(String(describing: error?.localizedDescription))")
                }
            }.resume()
        }
    }
}
