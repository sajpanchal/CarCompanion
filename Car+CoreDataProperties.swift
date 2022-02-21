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
    @NSManaged public var odometer: Double
    @NSManaged public var plateNumber: String?
    @NSManaged public var timeStamp: Date?
    @NSManaged public var dashboard: CarDashboard?
    @NSManaged public var driver: Driver?
    
    public var TimeStamp: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .long
        return dateFormatter.string(from: timeStamp!)
    }
    static func fetchData() -> Car?{
        var car: Car?
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            car = try viewContext.fetch(Self.fetchRequest()).first
        }
        catch {
            print("couldn't fetch it.")
        }
        return car
    }

}

extension Car : Identifiable {

}
