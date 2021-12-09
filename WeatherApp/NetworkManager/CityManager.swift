//
//  CityManager.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 09.12.2021.
//

import Foundation

class CityManager {
    
    func getCity(searchItem: String) async throws -> [CitiesArray] {

        guard let url = URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/cities?limit=10&namePrefix=\(searchItem)&rapidapi-key=a28db85951msh3f0e6abbf8d9681p1ff8f0jsn79f9cc500054") else {
            throw NetworkCityError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkCityError.badID
        }
        
        let cityResponse = try? JSONDecoder().decode(CitiesResponse.self, from: data)
        return cityResponse?.cities ?? []
    }
    
}

enum NetworkCityError: Error {
    case badURL
    case badID
}
