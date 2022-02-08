//
//  Configurator.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 07.01.2022.
//

import Foundation
import CoreServices

class Configurator {
    
    static let shared = Configurator()

    func register() {

        ServiceLocator.shared.addServices(service: LocationManager())
        ServiceLocator.shared.addServices(service: LanguageDetection())
//        ServiceLocator.shared.addServices(service: WeatherReceive<WeatherResponse>())
//        ServiceLocator.shared.addServices(service: CitiesReceive<CitiesResponse>())
        ServiceLocator.shared.addServices(service: NetworkReceive())
        ServiceLocator.shared.addServices(service: Api())
    }
}
