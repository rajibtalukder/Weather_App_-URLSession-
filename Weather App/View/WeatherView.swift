import SwiftUI

struct WeatherView: View {
  
    
    var body: some View {
       //@State var mymsg : String  = "Sylhet"
        @StateObject var viewModel = WeatherViewModel()
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.cyan.opacity(0.9), .indigo.opacity(0.9)],
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    HStack {
                        TextField("Search City...", text: $viewModel.cityName)
                            .textFieldStyle(.plain)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .autocorrectionDisabled()
                        
                        Button {
                            Task { await viewModel.getWeatherForecast() }
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.gray)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    switch viewModel.state {
                        case .idle:
                            PlaceholderStateView(message: "Enter a city to see the weather forecast.", icon: "cloud.sun.fill")
                                            
                        case .loading:
                            ProgressView()
                            .scaleEffect(1.5).tint(.white)
                                            
                        case .success(let data):
                            WeatherMetricsDisplay(data: data)
                                            
                        case .failure(
                            let errorDescription):
                            PlaceholderStateView(message: errorDescription, icon: "exclamationmark.triangle.fill")
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Weather")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

struct PlaceholderStateView: View {
    let message: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 64))
                .foregroundColor(.white.opacity(0.7))
            Text(message)
                .font(.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
    }
}


struct WeatherMetricsDisplay: View {
    let data: WeatherResponse
    var body: some View {
        VStack(spacing: 16) {
            Text(data.name)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text("\(Int(data.main.temp))°C")
                .font(.system(size: 72, weight: .thin))
                .foregroundColor(.white)
            
            Text(data.weather.first?.description.capitalized ?? "")
                .font(.title2)
                .foregroundColor(.white.opacity(0.9))
            
            HStack(spacing: 40) {
                MetricItem(title: "Feels Like", value: "\(Int(data.main.feelsLike))°C", icon: "thermometer")
                MetricItem(title: "Humidity", value: "\(data.main.humidity)%", icon: "humidity")
                MetricItem(title: "Wind", value: "\(Int(data.wind.speed)) m/s", icon: "wind")
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(20)
        }
    }
}

struct MetricItem: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.white)
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
            Text(value)
                .font(.headline)
                .foregroundColor(.white)
        }
    }
}


#Preview {
    WeatherView()
}
