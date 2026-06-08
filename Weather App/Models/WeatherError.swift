//
//  WeatherError.swift
//  Weather App
//
//  Created by MAC01 on 08/06/2026.
//

import Foundation

// MARK: - Networking Internal Errors
enum WeatherError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case serverError(Int)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "The endpoint request URL generated was invalid."
        case .invalidResponse: return "Received an erratic response from the server."
        case .decodingError: return "Failed parsing complex backend model structures."
        case .serverError(let code): return "Server rejected transaction with status code: \(code)."
        case .unknown(let error): return error.localizedDescription
        }
    }
}
