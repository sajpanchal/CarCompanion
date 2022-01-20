//
//  CarDashboard+CoreDataProperties.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-20.
//
//

import Foundation
import CoreData


extension CarDashboard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarDashboard> {
        return NSFetchRequest<CarDashboard>(entityName: "CarDashboard")
    }

    @NSManaged public var currentTravel: Double
    @NSManaged public var currentFuel: Double
    @NSManaged public var odometer: Double

}

extension CarDashboard : Identifiable {

}
