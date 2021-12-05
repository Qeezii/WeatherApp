//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 12.10.2021.
//

import SwiftUI
import CoreLocation

struct SettingsView: View {

    var body: some View {
        
        Text("Test")

//        VStack {
//            if let location = locationManager.location {
//                Text("Your location: \(location.latitude), \(location.longitude)")
//            } else {
//                Text("Locationg user location...")
//            }
//            Button {
//                locationManager.requestLocation()
//                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
//                    if let location = locationManager.location {
//
//                        print("\n \(location) \n \(String(format: "%.2f", location.latitude)) \n \(String(format: "%.2f", location.longitude)) \n")
//
//                        let geoCoder = CLGeocoder()
//                        let currentLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
//                        geoCoder.reverseGeocodeLocation(currentLocation) { placemarks, error -> Void in
//
//                            guard let placeMark = placemarks?.first else { return }
//                            if let locationName = placeMark.location {
//                                print("\n Location name: \(locationName) \n")
//                            }
//                            if let street = placeMark.thoroughfare {
//                                print("\n Street: \(street) \n")
//                            }
//                            if let city = placeMark.subAdministrativeArea {
//                                print("\n City: \(city) \n")
//                                cityViewModel.city = city
//                            }
//                            if let zip = placeMark.isoCountryCode {
//                                print("\n Zip: \(zip) \n")
//                            }
//                            if let country = placeMark.country {
//                                print("\n Country: \(country) \n")
//                            }
//                        }
//                    }
//                }
//            } label: {
//                Text("Test")
//            }
//
//        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
