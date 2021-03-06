//
//  ServiceRecords+CoreDataProperties.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-04-21.
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
    @NSManaged public var uniqueID: UUID?
    @NSManaged public var carDashboard: CarDashboard?
    @NSManaged public var services: NSSet?
    
    public var servicesArray: [Services] {
        let set = services as? Set<Services> ?? []
        return set.sorted {
            $0.desc! > $1.desc!
        }
    }

    public var DateOfService: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .long
       return formatter.string(from: dateOfService!)
    }
    
    public var UniqueID: UUID {
        return uniqueID ?? UUID()
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
