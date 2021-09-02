//
//  CategoryModel.swift
//  Хочупомочь
//
//  Created by Булат on 29.04.2021.
//

import Foundation
import UIKit

struct Post : Codable {
    let userId : Int
    let postId : Int
    let title :String
    let body : String
    
    enum CodingKeys: String, CodingKey {
        case userId
        case postId = "id"
        case title
        case body
    }
}

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

struct CategoryRoot : Codable {
    let id : Int
    let name : String
    let image : String
    let events : [Event]?
    init(id : Int, name: String, image : String, events : [Event]) {
        self.id = id
        self.name = name
        self.image = image
        self.events = events
    }
}

struct EventRoot : Codable {
    let id : Int
    let title : String
    let description : String
    let footer : String
    let fundName : String
    let adress : String
    let phone : String
    let description2 : String
    var mainImage :  String
    var image2 : String
    var image3 : String
    init(id : Int,title : String, description : String, footer : String, fundName : String,
         adress : String, phone : String, description2 : String, mainImage : String, image2 : String, image3 : String) {
        self.id = id
        self.title = title
        self.description = description
        self.footer = footer
        self.fundName = fundName
        self.adress = adress
        self.phone = phone
        self.description2 = description2
        self.mainImage = mainImage
        self.image2 = image2
        self.image3 = image3
    }
}

struct CategoryEntity {
    var id : Int16
    var name : String?
    var image : String?
    var events : NSSet?
}
