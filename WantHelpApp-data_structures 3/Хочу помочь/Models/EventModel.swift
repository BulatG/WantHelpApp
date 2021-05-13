//
//  EventModel.swift
//  Хочупомочь
//
//  Created by Булат on 29.04.2021.
//

import Foundation
import UIKit

struct Event : Codable {
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
