//
//  WeatherResponse.swift
//  Weather App
//
//  Created by MAC01 on 08/06/2026.
//

import Foundation

struct WeatherResponse: Decodable {
    let name: String
    let main: MainMetrics
    let weather: [WeatherCondition]
    let wind: WindMetrics
}

struct MainMetrics: Decodable {
    let temp: Double
    let feelsLike: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case humidity
    }
}

struct WeatherCondition: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct WindMetrics: Decodable {
    let speed: Double
}


