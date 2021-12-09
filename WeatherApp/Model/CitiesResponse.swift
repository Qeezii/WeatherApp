//
//  CitiesResponse.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 09.12.2021.
//

import Foundation

struct CitiesResponse: Decodable {
    let cities: [CitiesArray]
    
    private enum CodingKeys: String, CodingKey {
        case cities = "data"
    }
}

struct CitiesArray: Decodable {
    let id: Int
    let name: String
    let country: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case country = "country"
    }
    
}
