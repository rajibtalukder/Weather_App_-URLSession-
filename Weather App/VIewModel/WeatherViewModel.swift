
import Foundation
internal import Combine

enum ViewState {
    case idle
    case loading
    case success(WeatherResponse)
    case failure(String)
}

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published private(set) var state: ViewState = .idle
    @Published var cityName: String = ""
    
    private let networkService: WeatherServiceProtocol
        
        init(networkService: WeatherServiceProtocol = WeatherService()) {
            self.networkService = networkService
        }
    
    func getWeatherForecast() async {
        let inputCity = cityName.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !inputCity.isEmpty else { return }
                
                state = .loading
                
                do {
                    let weatherData = try await networkService.fetchCurrentWeather(for: inputCity)
                    state = .success(weatherData)
                } catch let error as WeatherError {
                    state = .failure(error.errorDescription ?? "An error occurred.")
                } catch {
                    state = .failure(error.localizedDescription)
                }
    }
}
