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
                HStack {
                    TextField("Enter City", text: $searchCity)
                        .padding(.horizontal, 20)
                        .padding(.leading, 20)
                        .foregroundColor(Color.black)
                    Button {
                        cityViewModel.city = searchCity
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

                List(cityViewModel.citiesList.filter({ searchCity.count > 2 && "\($0)".contains(searchCity) }), id: \.id) { city in
                    Button(action: {
                        cityViewModel.city = city.name
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
