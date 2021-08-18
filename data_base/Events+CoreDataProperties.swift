//
//  Events+CoreDataProperties.swift
//  Хочупомочь
//
//  Created by Булат on 12.08.2021.
//
//

import Foundation
import CoreData


extension Events {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Events> {
        return NSFetchRequest<Events>(entityName: "Events")
    }

    @NSManaged public var title: String?
    @NSManaged public var des: String?
    @NSManaged public var id: Int16
    @NSManaged public var footer: String?
    @NSManaged public var fundName: String?
    @NSManaged public var adress: String?
    @NSManaged public var phone: String?
    @NSManaged public var desTwo: String?
    @NSManaged public var mainImage: String?
    @NSManaged public var imaageTwo: String?
    @NSManaged public var imageThree: String?
    @NSManaged public var category: Categories?

}

extension Events : Identifiable {

}
