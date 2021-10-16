//
//  Cities.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 14.10.2021.
//

import Foundation

struct Cities: Hashable,Codable, Identifiable {
    var country: String
    var name: String
    var lat: String
    var lng: String

    enum CodingKey: String {
        case country
        case name
        case lat
        case lng
    }

    init() {
        country = ""
        name = ""
        lat = ""
        lng = ""
    }
}

extension Cities {
    var id: UUID {
        return UUID()
    }
}
