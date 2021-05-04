//
//  Servce .swift
//  Хочупомочь
//
//  Created by Булат on 29.04.2021.
//

import Foundation
import UIKit

class Servise {
    
    func takeFileEvents() {
        if let event = Bundle.main.path(forResource: "events", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: event)
                print(contents)
            } catch {
                print("Contents could not be loaded.")
            }
        } else {
            print("newTest.txt not found.")
        }
    }
    public func takeFileCategory() {
        if let event = Bundle.main.path(forResource: "category", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: event)
                print(contents)
            } catch {
                print("Contents could not be loaded.")
            }
        } else {
            print("newTest.txt not found.")
        }
    }
}

