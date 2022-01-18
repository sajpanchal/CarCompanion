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
    
    override init() {
        super.init()
        manager.delegate = self
        
        manager.requestAlwaysAuthorization()
        
        manager.pausesLocationUpdatesAutomatically = false
        
        manager.allowsBackgroundLocationUpdates = true
        manager.showsBackgroundLocationIndicator = true
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
        distance += abs(Double(difference!)/1000)
        
        speed = Double(lastLocation!.speed)/3.6
    }
}
