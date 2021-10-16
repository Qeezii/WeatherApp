//
//  Api.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 12.10.2021.
//

import Foundation

struct Api {
    static let key = "0a7d5a73e88d8d41d76d90bb356188d4"
    static let baseUrl = "https://api.openweathermap.org/data/2.5/"

    static func getUrlFor(lat: Double, lon: Double) -> String {
        return "\(baseUrl)onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(key)&units=metric"
    }
}

// New API "0a7d5a73e88d8d41d76d90bb356188d4"
// Old API "57fb792caaba24fafe12c3387792a565"

