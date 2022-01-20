//
//  LocationFetcher.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-18.
//

import Foundation
import CoreLocation

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
        if carDashboard == nil {
            carDashboard = CarDashboard(context: viewContext)
            carDashboard?.odometer = 0.0
            carDashboard?.currentTravel = 0.0
            carDashboard?.currentFuel = 0.0
            print("carDashboard is nil")
            do {
                try self.viewContext.save()
            }
            catch {
                print("Save failed")
            }
        }
        else {
            do {
                carDashboard = try viewContext.fetch(CarDashboard.fetchRequest()).first!
                print("data found\n odometer:", carDashboard?.odometer)
                print("current travel:", carDashboard?.currentTravel)
            }
            catch {
                print("error fetching data")
            }
        }
            
      
    }
    
    func start() {
        manager.startUpdatingLocation()
        if carDashboard == nil {
            carDashboard = CarDashboard(context: viewContext)
            carDashboard?.odometer = 0.0
            carDashboard?.currentTravel = 0.0
            carDashboard?.currentFuel = 0.0
            print("carDashboard is nil")
            do {
                try self.viewContext.save()
            }
            catch {
                print("Save failed")
            }
        }
        else {
            do {
                carDashboard = try viewContext.fetch(CarDashboard.fetchRequest()).first!
                print("data found\n odometer:", carDashboard?.odometer)
                print("current travel:", carDashboard?.currentTravel)
            }
            catch {
                print("error fetching data")
            }
        }
        
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
        do {
            try self.viewContext.save()
        }
        catch {
            print("Save failed")
        }
        
        speed = Double(lastLocation!.speed)/3.6
    }
}
