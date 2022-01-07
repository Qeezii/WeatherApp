//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 12.10.2021.
//

import Foundation

import SwiftUI
import CoreLocation
import CoreServices

final class CityViewModel: ObservableObject {
    
    @Injected var locationManager: LocationManager?
    @Injected var weatherRecive: WeatherRecive<WeatherResponse>?
    @Injected var citiesRecive: CitiesRecive<CitiesResponse>?
    @Injected var api: Api?
    @Injected var languageDetection: LanguageDetection?

    @Published var citiesArray = [CitiesArray]()
    @Published var weather = WeatherResponse.empty()
    @Published var city: String = UserDefaults.standard.string(forKey: "City") ?? "Moscow" {
        didSet {
            print("\n \(city) \n")
            getLocation()
        }
    }

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()

    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        return formatter
    }()
    
    private lazy var dayOfWeekFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter
    }()

    init() {
        getLocation()
    }

    var date: String {
        return dateFormatter.string(
            from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt))
        )
    }
    
    var weatherIcon: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].icon
        }
        return "dayClearSky"
    }
    
    var temperature: String {
        return getTempFor(temp: weather.current.temp)
    }
    
    var conditions: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].main
        }
        return ""
    }

    var feelLike: String {
        return getTempFeelLikeFor(temp: weather.current.feels_like)
    }

    var windSpeed: String {
        return String(format: "%0.1f", weather.current.wind_speed)
    }

    var pressure: String {
        return String(weather.current.pressure)
    }
    
    var humidity: String {
        return String(format: "%d%%", weather.current.humidity)
    }
    
    var rainChances: String {
        return String(format: "%0.1f%%", weather.current.dew_point)
    }
    
    func getTimeFor(timestamp: Int) -> String {
        return timeFormatter.string(
            from: Date(timeIntervalSince1970: TimeInterval(timestamp))
        )
    }
    
    func getCity(searchCityName: String) async {
        
        let language = languageDetection?.detectLanguage(text: searchCityName) ?? "en"
        guard let urlString = api?.getUrlForCities(searchCityName: searchCityName, languageSearch: language) else { return }
        guard let url = URL(string: urlString.encodeUrl) else { return }
        getCitiesRecive(for: url)
    }

    func getUserLocation() {
        
        locationManager?.requestLocation()
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            
            if let location = self.locationManager?.location {
                
                print("\n \(location) \n \(String(format: "%.2f", location.latitude)) \n \(String(format: "%.2f", location.longitude)) \n")
                
                let geoCoder = CLGeocoder()
                let currentLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
                geoCoder.reverseGeocodeLocation(currentLocation) { placemarks, error -> Void in
                    
                    guard let placeMark = placemarks?.first else { return }
                    if let locationName = placeMark.location {
                        print("\n Location name: \(locationName) \n")
                    }
                    if let street = placeMark.thoroughfare {
                        print("\n Street: \(street) \n")
                    }
                    if let city = placeMark.subAdministrativeArea {
                        print("\n City: \(city) \n")
                        self.city = city
                        UserDefaults.standard.set(city, forKey: "City")
                    }
                    if let zip = placeMark.isoCountryCode {
                        print("\n Zip: \(zip) \n")
                    }
                    if let country = placeMark.country {
                        print("\n Country: \(country) \n")
                    }
                }
                self.citiesArray.removeAll()
            }
        }
    }

    func getTempFor(temp: Double) -> String {
        return String(format: "%0.0f", temp)
    }

    func getTempFeelLikeFor(temp: Double) -> String {
        return String(format: "%0.0f", temp)
    }

    func getDayOfWeekFor(timestamp: Int) -> String {
        return dayOfWeekFormatter.string(
            from: Date(timeIntervalSince1970: TimeInterval(timestamp))
        )
    }

    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(
            from: Date(timeIntervalSince1970: TimeInterval(timestamp))
        )
    }

    func getWeatherInCurrentLocation(coord: CLLocationCoordinate2D) {
        guard let urlString = api?.getUrlForWeatherWith(lat: coord.latitude, lon: coord.longitude) else { return }
        guard let url = URL(string: urlString) else { return }
        getWeatherRecive(for: url)
    }

    private func getLocation() {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks, let place = places.first {
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }

    private func getWeather(coord: CLLocationCoordinate2D?) {
        if let coord = coord {
            guard let urlString = api?.getUrlForWeatherWith(lat: coord.latitude, lon: coord.longitude) else { return }
            guard let url = URL(string: urlString) else { return }
            getWeatherRecive(for: url)
        } else {
            guard let urlString = api?.getUrlForWeatherWith(lat: 0, lon: 0) else { return }
            guard let url = URL(string: urlString) else { return }
            getWeatherRecive(for: url)
        }
    }

    private func getWeatherRecive(for url: URL) {
        weatherRecive?.fetch(for: url) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.weather = response
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func getCitiesRecive(for url: URL) {
        citiesRecive?.fetch(for: url) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.citiesArray = response.cities
                }
            case .failure(let err):
                print(err)
            }
        }
    }

    func getLottieAnimationFor(icon: String) -> String {
        switch icon {
        case "01d":
            return "dayClearSky"
        case "01n":
            return "nightClearSky"
        case "02d":
            return "dayFewClouds"
        case "02n":
            return "nightFewClouds"
        case "03d":
            return "dayScatteredClouds"
        case "03n":
            return "nightScatteredClouds"
        case "04d":
            return "dayBrokenClouds"
        case "04n":
            return "nightBrokenClouds"
        case "09d":
            return "dayShowerRains"
        case "09n":
            return "nightShowerRains"
        case "10d":
            return "dayRain"
        case "10n":
            return "nightRain"
        case "11d":
            return "dayThunderstorm"
        case "11n":
            return "nightThunderstorm"
        case "13d":
            return "daySnow"
        case "13n":
            return "nightSnow"
        case "50d":
            return "dayClearSky"
        case "50n":
            return "dayClearSky"
        default:
            return "dayClearSky"
        }
    }

    func getWeatherIconFor(icon: String) -> Image {
        switch icon {
        case "01d":
            return Image(systemName: "sun.max.fill")
        case "01n":
            return Image(systemName: "moon.fill")
        case "02d":
            return Image(systemName: "cloud.sun.fill")
        case "02n":
            return Image(systemName: "cloud.moon.fill")
        case "03d":
            return Image(systemName: "cloud.fill")
        case "03n":
            return Image(systemName: "cloud.fill")
        case "04d":
            return Image(systemName: "cloud.fill")
        case "04n":
            return Image(systemName: "cloud.fill")
        case "09d":
            return Image(systemName: "cloud.drizzle.fill")
        case "09n":
            return Image(systemName: "cloud.drizzle.fill")
        case "10d":
            return Image(systemName: "cloud.heavyrain.fill")
        case "10n":
            return Image(systemName: "cloud.heavyrain.fill")
        case "11d":
            return Image(systemName: "cloud.bolt.fill")
        case "11n":
            return Image(systemName: "cloud.bolt.fill")
        case "13d":
            return Image(systemName: "cloud.snow.fill")
        case "13n":
            return Image(systemName: "cloud.snow.fill")
        case "50d":
            return Image(systemName: "cloud.fog.fill")
        case "50n":
            return Image(systemName: "cloud.fog.fill")
        default:
            return Image(systemName: "sun.max.fill")
        }
    }
}
