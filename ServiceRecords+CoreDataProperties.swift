//
//  ServiceRecords+CoreDataProperties.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-04-10.
//
//

import Foundation
import CoreData


extension ServiceRecords {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ServiceRecords> {
        return NSFetchRequest<ServiceRecords>(entityName: "ServiceRecords")
    }

    @NSManaged public var dateOfService: Date?
    @NSManaged public var shopName: String?
    @NSManaged public var totalCost: Double
    @NSManaged public var carDashboard: CarDashboard?
    @NSManaged public var services: NSSet?

    public var DateOfService: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .long
       return formatter.string(from: dateOfService!)
    }
}

// MARK: Generated accessors for services
extension ServiceRecords {

    @objc(addServicesObject:)
    @NSManaged public func addToServices(_ value: Services)

    @objc(removeServicesObject:)
    @NSManaged public func removeFromServices(_ value: Services)

    @objc(addServices:)
    @NSManaged public func addToServices(_ values: NSSet)

    @objc(removeServices:)
    @NSManaged public func removeFromServices(_ values: NSSet)

}

extension ServiceRecords : Identifiable {

}
