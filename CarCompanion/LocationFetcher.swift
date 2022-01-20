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
    var carDashboard: CarDashboard?
    
    override init() {
        super.init()
        manager.delegate = self
        
        manager.requestAlwaysAuthorization()
        
        manager.pausesLocationUpdatesAutomatically = false
        
        manager.allowsBackgroundLocationUpdates = true
        manager.showsBackgroundLocationIndicator = true
        
        carDashboard = CarDashboard.fetchData(viewContext: viewContext)
        
        if carDashboard == nil {
            carDashboard = CarDashboard(context: viewContext)
            carDashboard?.odometer = 0.0
            carDashboard?.currentTravel = 0.0
            carDashboard?.currentFuel = 0.0
            print("carDashboard is nil")
            CarDashboard.saveContext(viewContext: viewContext)
        }
        print("data found\n odometer:", carDashboard!.odometer)
        print("current travel:", carDashboard!.currentTravel)
            
      
    }
    
    func start() {
        manager.startUpdatingLocation()
                
    }
    
    func stop() {
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = lastLocation ?? locations.last
        lastLocation = locations.last
        
        let difference = lastLocation?.distance(from: currentLocation!)
        carDashboard?.currentTravel += abs(Double(difference!)/1000)
        carDashboard?.odometer += abs(Double(difference!)/1000)
        CarDashboard.saveContext(viewContext: viewContext)
        
        speed = Double(lastLocation!.speed)/3.6
    }
}
