//
//  CategoryModel.swift
//  Хочупомочь
//
//  Created by Булат on 29.04.2021.
//

import Foundation
import UIKit

struct Category: Codable {
    let id : Int
    let name : String
    let image : String
    init(id : Int, name: String, image : String) {
        self.id = id
        self.name = name
        self.image = image
    }
}

struct CategoryEntity {
    var id : Int16
    var name : String?
    var image : String?
    var events : NSSet?
}
