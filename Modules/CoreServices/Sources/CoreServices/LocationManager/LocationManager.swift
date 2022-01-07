//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 21.11.2021.
//

import Foundation
import CoreLocation

public class LocationManager: NSObject, ObservableObject {

    private let locationManager = CLLocationManager()
    
    public var location: CLLocationCoordinate2D?
    
    var defaultCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: 37.332331, longitude: -122.031219)
    }

    public override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }
}

extension LocationManager: CLLocationManagerDelegate {

    public func requestLocation() {
        locationManager.startUpdatingLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first?.coordinate else { return }
        
        DispatchQueue.main.async {
            self.location = location
        }
    }
}
