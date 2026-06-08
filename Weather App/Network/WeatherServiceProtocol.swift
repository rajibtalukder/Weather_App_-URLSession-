//
//  WeatherServiceProtocol.swift
//  Weather App
//
//  Created by MAC01 on 08/06/2026.
//

import Foundation


protocol WeatherServiceProtocol {
    func fetchCurrentWeather(for city: String) async throws -> WeatherResponse
}
