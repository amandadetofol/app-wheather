import Foundation
import CoreLocation

enum Endpoints: String {
    case baseUrl = "http://api.openweathermap.org/data/2.5/"
    case wheather = "weather"
}

protocol ServiceProtocol {
    func url(latitude: Double, longitude: Double) -> String
    func getWheatherData(lagitude: Int, longitude: Int,completion: @escaping (WheatherData?, Error?) -> Void)
}

class Service: ServiceProtocol {
    
    private let apiKey: String = "109f55dbb3185aa600ec1c95ea521ff4"
    
    func url(latitude: Double, longitude: Double) -> String {
        return "\(Endpoints.baseUrl.rawValue)\(Endpoints.wheather.rawValue)?lat=\(latitude)&lon=\(longitude)&appid=\(self.apiKey)"
    }
    
    func getWheatherData(lagitude: Int, longitude: Int, completion: @escaping (WheatherData?, Error?) -> Void) {
        guard let url = URL(string: self.url(latitude: Double(lagitude), longitude: Double(longitude))) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == StatusCode.success200.rawValue {
                guard let data = data else { return }
                do {
                    let wheather = try JSONDecoder().decode(WheatherData.self, from: data)
                        completion(wheather, nil)
                } catch {
                        completion(nil, error)
                }
            }
        }.resume()
        
    }
}
