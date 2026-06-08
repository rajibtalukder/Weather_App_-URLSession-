
import Foundation
internal import Combine

enum ViewState {
    case idle
    case loading
    case success(Void)
    case failure(String)
}

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published private(set) var state: ViewState = .idle
    @Published var cityName: String = ""
    

    
    func getWeatherForecast() async {
      
    }
}
