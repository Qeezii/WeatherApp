//
//  WeatherReceive.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 12.10.2021.
//

import Foundation
import CoreServices

public class WeatherReceive {
    
    private var network: NetworkReceive

    init(network: NetworkReceive) {
        self.network = network
    }
    
    func getWeatherRecive(for url: URL, complition: @escaping (WeatherResponse) -> () ) {
        network.fetch(WeatherResponse.self, for: url, completion: { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    complition(response)
                }
            case .failure(let err):
                print(err)
            }
        })
    }
}
