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
        ServiceLocator.shared.addServices(service: WeatherRecive<WeatherResponse>())
        ServiceLocator.shared.addServices(service: CitiesRecive<CitiesResponse>())
        ServiceLocator.shared.addServices(service: Api())
    }
}
