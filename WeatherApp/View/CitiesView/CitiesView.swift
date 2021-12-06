//
//  CitiesView.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 12.10.2021.
//

import SwiftUI
import CoreLocation

struct CitiesView: View {

    @EnvironmentObject var cityViewModel: CityViewModel
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var locationManager = LocationManager()
    @State private var searchCity = ""

    var body: some View {
        NavigationView {
            VStack {
                
                // Find city textfield
                HStack {
                    TextField("Enter City", text: $searchCity)
                        .padding(.horizontal, 20)
                        .padding(.leading, 20)
                        .foregroundColor(Color.black)
                    Button {
                        cityViewModel.city = searchCity
                        UserDefaults.standard.set(searchCity, forKey: "City")
                        hideKeyboard()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue.opacity(0.3))
                            Image(systemName: "arrowtriangle.right")
                        }
                        .foregroundColor(Color.white)
                    }
                    .frame(width: 30, height: 30)
                }
                .background(
                    ZStack(alignment: .leading) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                })

                // Request user`s location button
                Button {
                    locationManager.requestLocation()
                    Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                        if let location = locationManager.location {

                            print("\n \(location) \n \(String(format: "%.2f", location.latitude)) \n \(String(format: "%.2f", location.longitude)) \n")
                            
                            let geoCoder = CLGeocoder()
                            let currentLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
                            geoCoder.reverseGeocodeLocation(currentLocation) { placemarks, error -> Void in

                                guard let placeMark = placemarks?.first else { return }
                                if let locationName = placeMark.location {
                                    print("\n Location name: \(locationName) \n")
                                }
                                if let street = placeMark.thoroughfare {
                                    print("\n Street: \(street) \n")
                                }
                                if let city = placeMark.subAdministrativeArea {
                                    print("\n City: \(city) \n")
                                    cityViewModel.city = city
                                    UserDefaults.standard.set(city, forKey: "City")
                                }
                                if let zip = placeMark.isoCountryCode {
                                    print("\n Zip: \(zip) \n")
                                }
                                if let country = placeMark.country {
                                    print("\n Country: \(country) \n")
                                }
                            }
                            hideKeyboard()
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "location")

                        Text("Текущее местоположение")
                    }
                }
                .padding(.top, 5)

                // City list
                List(cityViewModel.citiesList.filter({ searchCity.count > 2 && "\($0)".contains(searchCity) }), id: \.id) { city in
                    Button(action: {
                        cityViewModel.city = city.name
                        UserDefaults.standard.set(city.name, forKey: "City")
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        CityRow(cities: city)
                    })
                }
            }
        }
        .navigationTitle("Cities")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

//struct CitiesView_Previews: PreviewProvider {
//    static var previews: some View {
//        CitiesView()
//    }
//}
