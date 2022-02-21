//
//  Driver+CoreDataProperties.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-09.
//
//

import Foundation
import CoreData


extension Driver {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Driver> {
        return NSFetchRequest<Driver>(entityName: "Driver")
    }

    @NSManaged public var name: String?
    @NSManaged public var licenseNumber: String?
    @NSManaged public var car: NSSet?
    
    public var Cars: [Car] {
        let set = car as? Set<Car> ?? []
        return set.sorted {
            $0.model! < $1.model!
        }
    }
    static func fetchData(viewContext: NSManagedObjectContext) -> Driver?{
        var driver: Driver?
        do {
            driver = try viewContext.fetch(Self.fetchRequest()).first
        }
        catch {
            print("couldn't fetch it.")
        }
        return driver
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
}

// MARK: Generated accessors for car
extension Driver {

    @objc(addCarObject:)
    @NSManaged public func addToCar(_ value: Car)

    @objc(removeCarObject:)
    @NSManaged public func removeFromCar(_ value: Car)

    @objc(addCar:)
    @NSManaged public func addToCar(_ values: NSSet)

    @objc(removeCar:)
    @NSManaged public func removeFromCar(_ values: NSSet)

}

extension Driver : Identifiable {

}
