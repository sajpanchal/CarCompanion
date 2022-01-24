//
//  FuelEfficiency+CoreDataProperties.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-24.
//
//

import Foundation
import CoreData


extension FuelEfficiency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FuelEfficiency> {
        return NSFetchRequest<FuelEfficiency>(entityName: "FuelEfficiency")
    }

    @NSManaged public var efficiency: Double
    @NSManaged public var fuel: Double
    @NSManaged public var timeStamp: Date?
    @NSManaged public var travel: Double
    @NSManaged public var carDashboard: CarDashboard?
    
    public var TimeStamp: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .long
        return dateFormatter.string(from: timeStamp!)
    }
    static func saveContext(viewContext: NSManagedObjectContext) {
        do {
            try viewContext.save()
            print("record saved!")
        }
        catch {
            print("Error saving fuelEfficiency context!")
        }
    }

}

extension FuelEfficiency : Identifiable {

}
