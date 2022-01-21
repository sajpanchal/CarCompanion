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
    
    static func saveContext(viewContext: NSManagedObjectContext) {
        do {
            try viewContext.save()
        }
        catch {
            print("save failed")
        }
    }
    static func fetchData(viewContext: NSManagedObjectContext) -> CarDashboard?{
        var carDashboard: CarDashboard?
        do {
            carDashboard = try viewContext.fetch(Self.fetchRequest()).first
            print("fetch successful")
        }
        catch {
            print("couldn't fetch it.")
        }
        return carDashboard
    }

}

extension CarDashboard : Identifiable {

}
