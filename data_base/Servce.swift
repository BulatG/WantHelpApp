//
//  Servce .swift
//  Хочупомочь
//
//  Created by Булат on 29.04.2021.
//

import Foundation
import UIKit
class Servise {
    //let semaPhore = DispatchSemaphore(value: 1)
    public func takeFileCategory(completion: @escaping ((Result<[Category], Error>) -> Void)) {
        
        //        var massivName : [String] = []
        //        var massivImage : [String] = []
        
        DispatchQueue.global(qos: .background).async {
            
            //            for index in 0..<Int.max {
            //                print("\(index)")
            //            }
            
            if let category = Bundle.main.path(forResource: "category", ofType: "json") {
                
                
                do {
                    let contents = try String(contentsOfFile: category)
                    print(contents)
                    let jsonData = Data(contents.utf8)
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([Category].self, from: jsonData)
                    print(result)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                    
                    //                    massivName = result.map { $0.name }
                    //                    massivImage = result.map { $0.image }
                    //                    for item in 0...result.count-1 {
                    //                        massivName.append(result[item].name)
                    //                    }
                    //                    for item in 0...result.count-1 {
                    //                        massivImage.append(result[item].image)
                    //                    }
                    
                    //print("МАССИВ \(massivName)")
                    
                }
                catch let error{
                    print("Contents could not be loaded.")
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    
                    //}
                }
            } else {
                print("newTest.txt not found.")
                let error = NSError()
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                
            }
        }
        //return (massivName,massivImage)
    }
    
    
    
    //func takeFileEvents()-> [Event] {
    func takeFileEvents(completion: @escaping ((Result<[Event], Error>) -> Void)) {
        //var massiv : [Event]  = []
        DispatchQueue.global(qos: .background).async {
            
            if let category = Bundle.main.path(forResource: "events", ofType: "json") {
                do {
                    let contents = try String(contentsOfFile: category)
                    print(contents)
                    let jsonData = Data(contents.utf8)
                    let decoder = JSONDecoder()
                    let res = try decoder.decode([Event].self, from: jsonData)
                    print(res[2])
                    DispatchQueue.main.async {
                        completion(.success(res))
                    }
                    //                for item in 0..<res.count {
                    //                    massiv.append(res[item])
                    //                }
                } catch let error{
                    print("Contents could not be loaded.")
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else {
                print("newTest.txt not found.")
                let error = NSError()
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            //return massiv
        }
    }
}
