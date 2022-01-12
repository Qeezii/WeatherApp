//
//  WeatherReceive.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 12.10.2021.
//

import Foundation

public class WeatherReceive<T: Codable> {
    
    public var network: NetworkReceive<T>

    public init() {
        self.network = NetworkReceive<T>()
    }
}
