//
//  City.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 12.10.2021.
//

import SwiftUI


struct City: View {

    @ObservedObject var cityViewModel: CityViewModel

    var body: some View {
        VStack {

            CityNameView(city: cityViewModel.city, date: cityViewModel.date)
                .padding(.bottom, 35)
                .padding(.top, 5)

            TodayWeather(cityViewModel: cityViewModel)
                .padding(.horizontal, 10)

            DailyWeather(cityViewModel: cityViewModel)
                .padding(. horizontal, 10)
        }

    }
}

//struct City_Previews: PreviewProvider {
//    static var previews: some View {
//        City(cityViewModel: CityViewModel())
//    }
//}
