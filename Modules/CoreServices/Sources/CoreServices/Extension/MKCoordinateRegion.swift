//
//  MKCoordinateRegion.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 21.11.2021.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    static var defaultRegion: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D.init(latitude: 29.726819, longitude: -95.393692), latitudinalMeters: 100, longitudinalMeters: 100)
    }
}
