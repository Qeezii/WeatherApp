//
//  TodayWeather.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 12.10.2021.
//

import SwiftUI

struct TodayWeather: View {
    @ObservedObject var cityViewModel: CityViewModel
//    @EnvironmentObject var cityViewModel: CityViewModel

    
    var body: some View {
        VStack(spacing: 10) {
            VStack {
                HStack(spacing: 0) {
                    Text("\(cityViewModel.temperature)°") // ℃
                        .font(.system(size: 62))
                        .padding(.top, 7)
                    LottieView(name: cityViewModel.getLottieAnimationFor(icon: cityViewModel.weatherIcon))
                        .frame(width: 100, height: 100)
                }

                Text(cityViewModel.conditions)
                Text("Feels like \(cityViewModel.feelLike)℃")
            }
            .padding(.bottom, 25)

            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Image(systemName: "wind")
                        Text("\(cityViewModel.windSpeed) km/hr")
                    }
                    .padding(.bottom, 5)

                    HStack {
                        Image(systemName: "barometer")
                        Text("\(cityViewModel.pressure) hPa")
                    }
                    .padding(.bottom, 5)

                    HStack {
                        Image(systemName: "drop").padding(.leading, 3)
                        Text("\(cityViewModel.humidity)").padding(.leading, 3)
                    }
                    .padding(.bottom, 5)

                    HStack {
                        Image(systemName: "umbrella")
                        Text("\(cityViewModel.rainChances)")
                    }
                }
                HourlyWeather(cityViewModel: cityViewModel)
            }
            .padding(.horizontal, -15)
        }
        .padding()
        .foregroundColor(.white)
    }
}

//
//struct TodayWeather_Previews: PreviewProvider {
//    static var previews: some View {
//        TodayWeather(cityViewModel: CityViewModel())
//            .environmentObject(cityViewModel)
//    }
//}
