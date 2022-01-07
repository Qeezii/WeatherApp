//
//  Api.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 12.10.2021.
//

import Foundation

public class Api {
    
    public let keyForWeather = "0a7d5a73e88d8d41d76d90bb356188d4"
    public let baseUrlForWeather = "https://api.openweathermap.org/data/2.5/"
    public let keyForCities = "a28db85951msh3f0e6abbf8d9681p1ff8f0jsn79f9cc500054"
    public let baseUrlForCities = "https://wft-geo-db.p.rapidapi.com/v1/geo/cities"
    
    public init() {}

    public func getUrlForWeatherWith(lat: Double, lon: Double) -> String {
        return "\(baseUrlForWeather)onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(keyForWeather)&units=metric"
    }
    
    public func getUrlForCities(searchCityName: String, languageSearch: String) -> String {
        return "\(baseUrlForCities)?limit=10&namePrefix=\(searchCityName)&languageCode=\(languageSearch)&rapidapi-key=\(keyForCities)"
    }
}

// New API "0a7d5a73e88d8d41d76d90bb356188d4"
// Old API "57fb792caaba24fafe12c3387792a565"

