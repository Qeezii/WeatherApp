//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 12.10.2021.
//

import SwiftUI

struct DailyWeather: View {
    @ObservedObject var cityViewModel: CityViewModel
    
    var body: some View {
        ForEach(cityViewModel.weather.daily) { weather in
            LazyVStack {
                dailyCell(weather: weather)
            }
        }
    }
    
    private func dailyCell(weather: WeatherDaily) -> some View {
        HStack {
            VStack {
                Text(cityViewModel.getDayFor(timestamp: weather.dt))
                    .padding(.leading, 15)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 14))
                Text(cityViewModel.getDayOfWeekFor(timestamp: weather.dt))
                .padding(.leading, 15)
                .foregroundColor(Color.black)
                .font(.system(size: 16))
            }

            Spacer()

            Text("\(cityViewModel.getWeatherIconFor(icon: weather.weather[0].icon))")
                .foregroundColor(Color.black)
                .padding(.trailing, 15)
            Text("\(cityViewModel.getTempFor(temp: weather.temp.max))℃")
                .foregroundColor(Color.black)
                .padding(.trailing, 10)
            Text("\(cityViewModel.getTempFor(temp: weather.temp.min))℃")
                .foregroundColor(Color.gray)
                .padding(.trailing, 15)
        }
        .padding(.vertical, 15)
    }
}

//struct DailyWeather_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyWeather(cityViewModel: CityViewModel())
//    }
//}
