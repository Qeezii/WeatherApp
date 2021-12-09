//
//  HourlyWeather.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 12.10.2021.
//

import SwiftUI

struct HourlyWeather: View {
    
    @ObservedObject var cityViewModel: CityViewModel
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 5) {
                
                ForEach(cityViewModel.weather.hourly) { weather in
                    let icon = cityViewModel.getWeatherIconFor(
                        icon: weather.weather.count > 0 ? weather.weather[0].icon : "sun.max.fill"
                    )
                    let hour = cityViewModel.getTimeFor(timestamp: weather.dt)
                    let temp = cityViewModel.getTempFor(temp: weather.temp)
                    
                    getHourlyView(hour: hour, image: icon, temp: temp)
                }
            }
        }
    }
    
    private func getHourlyView(hour: String, image: Image, temp: String) -> some View {
        
        VStack(spacing: 14) {
            
            Text(hour)
            
            image.foregroundColor(.white).fixedSize().font(.system(size: 25))
            
            Text("\(temp)℃")
        }
        .foregroundColor(.white)
        .padding(10)
    }
}

//struct HourlyWeather_Previews: PreviewProvider {
//    static var previews: some View {
//        HourlyWeather(cityViewModel: CityViewModel())
//            .environmentObject(cityViewModel)
//    }
//}
