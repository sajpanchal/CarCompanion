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
    @Published  var lastLocation: CLLocation?
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
        index = driver!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})
        if self.driver!.Cars[index ?? 0].dashboard == nil {
            self.driver!.Cars[index ?? 0].dashboard = CarDashboard(context: viewContext)
        }
        print("car index is found: \(index)")
      
    }
    
    func start() {
        driver = Driver.fetchData(viewContext: viewContext)
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
        CarDashboard.saveContext(viewContext: self.viewContext)                       
        speed = Double(lastLocation!.speed)/3.6
    }
}
