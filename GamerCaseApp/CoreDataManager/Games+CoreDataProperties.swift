//
//  Games+CoreDataProperties.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/18/23.
//
//

import Foundation
import CoreData


extension Games {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Games> {
        return NSFetchRequest<Games>(entityName: "Games")
    }

    @NSManaged public var image: String?
    @NSManaged public var metacritic: Int32
    @NSManaged public var name: String?
    @NSManaged public var genre: NSObject?

}
