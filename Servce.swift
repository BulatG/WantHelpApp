//
//  Servce .swift
//  Хочупомочь
//
//  Created by Булат on 29.04.2021.
//

import Foundation
import UIKit

class Servise {
    
    public func takeFileCategory() -> (masName: [String],masImage: [String]) {
        var massivName : [String] = []
        var massivImage : [String] = []
        if let category = Bundle.main.path(forResource: "category", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: category)
                print(contents)
                let jsonData = Data(contents.utf8)
                let decoder = JSONDecoder()
                let result = try decoder.decode([Category].self, from: jsonData)
                print(result)
                for item in 0...result.count-1 {
                    massivName.append(result[item].name)
                }
                for item in 0...result.count-1 {
                    massivImage.append(result[item].image)
                }
                print("МАССИВ \(massivName)")
            } catch {
                print("Contents could not be loaded.")
            }
        } else {
            print("newTest.txt not found.")
        }
        return (massivName,massivImage)
    }
    
    func takeFileEvents()-> [Event] {
        var massiv : [Event]  = []
        if let category = Bundle.main.path(forResource: "events", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: category)
                print(contents)
                let jsonData = Data(contents.utf8)
                let decoder = JSONDecoder()
                let res = try decoder.decode([Event].self, from: jsonData)
                print(res[2])
                for item in 0..<res.count {
                    massiv.append(res[item])
                }                
            } catch {
                print("Contents could not be loaded.")
            }
        } else {
            print("newTest.txt not found.")
        }
        return massiv
    }
}
