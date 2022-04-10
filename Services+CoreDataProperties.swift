//
//  Services+CoreDataProperties.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-04-10.
//
//

import Foundation
import CoreData


extension Services {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Services> {
        return NSFetchRequest<Services>(entityName: "Services")
    }

    @NSManaged public var cost: Double
    @NSManaged public var desc: String?
    @NSManaged public var serviceRecords: ServiceRecords?

}

extension Services : Identifiable {

}
