//
//  CarDashboard+CoreDataProperties.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-09.
//
//

import Foundation
import CoreData


extension CarDashboard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarDashboard> {
        return NSFetchRequest<CarDashboard>(entityName: "CarDashboard")
    }

    @NSManaged public var currentFuel: Double
    @NSManaged public var currentTravel: Double
    @NSManaged public var odometer: Double
    @NSManaged public var fuelEfficiency: NSSet?
    @NSManaged public var car: Car?

    public var fuelEfficiencyArray: [FuelEfficiency] {
        let set = fuelEfficiency as? Set<FuelEfficiency> ?? []
        return set.sorted {
            $0.timeStamp! > $1.timeStamp!
        }
    }
    
    static func saveContext(viewContext: NSManagedObjectContext) {
        do {
            try viewContext.save()
          //  print("car dashboard updated!")
        }
        catch {
            print("save failed")
        }
    }
    static func fetchData(viewContext: NSManagedObjectContext) -> CarDashboard?{
        var carDashboard: CarDashboard?
        do {
            carDashboard = try viewContext.fetch(Self.fetchRequest()).first
        }
        catch {
            print("couldn't fetch it.")
        }
        return carDashboard
    }

}

// MARK: Generated accessors for fuelEfficiency
extension CarDashboard {

    @objc(addFuelEfficiencyObject:)
    @NSManaged public func addToFuelEfficiency(_ value: FuelEfficiency)

    @objc(removeFuelEfficiencyObject:)
    @NSManaged public func removeFromFuelEfficiency(_ value: FuelEfficiency)

    @objc(addFuelEfficiency:)
    @NSManaged public func addToFuelEfficiency(_ values: NSSet)

    @objc(removeFuelEfficiency:)
    @NSManaged public func removeFromFuelEfficiency(_ values: NSSet)

}

extension CarDashboard : Identifiable {

}
