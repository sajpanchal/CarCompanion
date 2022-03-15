//
//  LocationFetcher.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-18.
//

import Foundation
import CoreLocation
import CoreData

class LocationFetcher: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var currentLocation: CLLocation?
    @Published var lastLocation: CLLocation?
    @Published var distance: Double = 0.0
    @Published var speed: CLLocationSpeed?
   
    var manager = CLLocationManager()
    var viewContext = PersistenceController.shared.container.viewContext
    @Published var driver: Driver?
    @Published var index: Int?
    
    override init() {
        super.init()
        print("Location fetch init Called.")
        manager.delegate = self
        
        manager.requestAlwaysAuthorization()
        
        manager.pausesLocationUpdatesAutomatically = false
        
        manager.allowsBackgroundLocationUpdates = true
        manager.showsBackgroundLocationIndicator = true
        
        driver = Driver.fetchData(viewContext: viewContext)
        if let driver = driver {
            print("Driver entity is not empty")
            if !driver.Cars.isEmpty {
                print("Car entity is not empty")
                index = self.driver!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!
                if index == nil {
                    print("index for car entity not found")
                    self.driver!.Cars[0].dashboard = CarDashboard(context: viewContext)
                    try? viewContext.save()
                }
            }
            else {
                print("Car entity is empty")
                self.driver!.Cars[0].dashboard = CarDashboard(context: viewContext)
                try? viewContext.save()
            }
            
        }
        
     
       
      /*print(self.driver)
       
       
       
       
       if index == nil || self.driver!.Cars.isEmpty {
           print("Cars entity is empty")
          
       }
       print("car index is found: \(self.index)")*/
      
    }
    
    func start() {
        driver = Driver.fetchData(viewContext: viewContext)
        
      
        if let driver = driver {
            print("Driver entity is not empty")
            if !driver.Cars.isEmpty {
                print("Car entity is not empty")
                index = self.driver!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!
                if index == nil {
                    print("index for car entity not found")
                    self.driver!.Cars[0].dashboard = CarDashboard(context: viewContext)
                
          
                    print( self.driver!.Cars[0].dashboard)
                }
                else {
                    if self.driver!.Cars[index!].dashboard == nil {
                        self.driver!.Cars[index!].dashboard = CarDashboard(context: viewContext)
                    }
                    print( self.driver!.Cars[index!].dashboard)
                }
            }
            else {
                print("Car entity is empty")
                self.driver!.Cars[0].dashboard = CarDashboard(context: viewContext)
                print( self.driver!.Cars[0].dashboard)
            }
            
        }
        
        manager.startUpdatingLocation()
    }
    
    func stop() {
        manager.stopUpdatingLocation()
        print("location updated stopped")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        currentLocation = lastLocation ?? locations.last
        lastLocation = locations.last
        
        let difference = lastLocation?.distance(from: currentLocation!)
        self.driver!.Cars[index ?? 0].dashboard!.currentTravel += abs(Double(difference!)/1000)
        self.driver!.Cars[index ?? 0].dashboard!.odometer += abs(Double(difference!)/1000)
        Driver.saveContext(viewContext: self.viewContext)
        speed = Double(lastLocation!.speed)/3.6
    }
}
