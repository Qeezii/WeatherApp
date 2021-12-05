//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 21.11.2021.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {

    private let locationManager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    var defaultCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: 37.332331, longitude: -122.031219)
    }

    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
//        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func requestLocation() {
//        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first?.coordinate else { return }
        DispatchQueue.main.async {
            self.location = location
        }
    }
}
