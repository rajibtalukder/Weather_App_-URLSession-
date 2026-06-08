//
//  WeatherService.swift
//  Weather App
//
//  Created by MAC01 on 08/06/2026.
//

import Foundation

final class WeatherService: WeatherServiceProtocol {
    private let apiKey = "" 
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchCurrentWeather(for city: String) async throws -> WeatherResponse {
        let sanitizedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(sanitizedCity)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            throw WeatherError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw WeatherError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw WeatherError.serverError(httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(WeatherResponse.self, from: data)
        } catch {
            throw WeatherError.decodingError(error)
        }
    }
}
