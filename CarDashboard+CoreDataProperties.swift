//
//  CarDashboard+CoreDataProperties.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-04-11.
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
    @NSManaged public var car: Car?
    @NSManaged public var fuelEfficiency: NSSet?
    @NSManaged public var serviceRecords: NSSet?
    
    public var serviceRecordsArray: [ServiceRecords] {
        let set = serviceRecords as? Set<ServiceRecords> ?? []
        return set.sorted {
            $0.dateOfService! > $1.dateOfService!
        }
    }
    
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

// MARK: Generated accessors for serviceRecords
extension CarDashboard {

    @objc(addServiceRecordsObject:)
    @NSManaged public func addToServiceRecords(_ value: ServiceRecords)

    @objc(removeServiceRecordsObject:)
    @NSManaged public func removeFromServiceRecords(_ value: ServiceRecords)

    @objc(addServiceRecords:)
    @NSManaged public func addToServiceRecords(_ values: NSSet)

    @objc(removeServiceRecords:)
    @NSManaged public func removeFromServiceRecords(_ values: NSSet)

}

extension CarDashboard : Identifiable {

}
