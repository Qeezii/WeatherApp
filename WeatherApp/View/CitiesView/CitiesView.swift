//
//  CitiesView.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 12.10.2021.
//

import SwiftUI

struct CitiesView: View {
    
    @EnvironmentObject var cityViewModel: CityViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var searchCity = ""
    
    var body: some View {
        NavigationView {
            VStack {
                userLocationButton
                citiesList
            }
        }
        .navigationTitle("Cities")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var userLocationButton: some View {
        Button {
            cityViewModel.getUserLocation()
            hideKeyboard()
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "location")
                Text("Текущее местоположение")
            }
        }
        .padding(.top, 5)
    }
    
    var citiesList: some View {
        List(cityViewModel.citiesArray, id: \.id) { city in
            
            Button(action: {
                cityViewModel.city = city.name
                UserDefaults.standard.set(city.name, forKey: "City")
                presentationMode.wrappedValue.dismiss()
                cityViewModel.citiesArray.removeAll()
            }, label: {
                CityRow(cities: city)
            })
            
        }.listStyle(.plain)
            .searchable(text: $searchCity)
            .onChange(of: searchCity) { value in
                Task {
                    if !value.isEmpty &&  value.count > 3 {
                        await cityViewModel.getCity(searchCityName: value)
                    } else {
                        cityViewModel.citiesArray.removeAll()
                    }
                }
            }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
