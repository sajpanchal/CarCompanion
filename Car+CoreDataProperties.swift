//
//  Car+CoreDataProperties.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-09.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var make: String?
    @NSManaged public var model: String?
    @NSManaged public var year: Int16
    @NSManaged public var fuelCapacity: Double
    @NSManaged public var plateNumber: String?
    @NSManaged public var dashboard: CarDashboard?
    @NSManaged public var driver: Driver?

}

extension Car : Identifiable {

}
