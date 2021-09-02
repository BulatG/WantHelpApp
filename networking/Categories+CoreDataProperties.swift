//
//  Categories+CoreDataProperties.swift
//  Хочупомочь
//
//  Created by Булат on 12.08.2021.
//
//

import Foundation
import CoreData


extension Categories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categories> {
        return NSFetchRequest<Categories>(entityName: "Categories")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var id: Int16
    @NSManaged public var events: NSSet?

}

// MARK: Generated accessors for events
extension Categories {

    @objc(addEventsObject:)
    @NSManaged public func addToEvents(_ value: Events)

    @objc(removeEventsObject:)
    @NSManaged public func removeFromEvents(_ value: Events)

    @objc(addEvents:)
    @NSManaged public func addToEvents(_ values: NSSet)

    @objc(removeEvents:)
    @NSManaged public func removeFromEvents(_ values: NSSet)

}

extension Categories : Identifiable {

}
