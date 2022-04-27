import CoreLocation

protocol MainViewModelProtocol {
    func requestLocationAuth()
}

class MainViewModel: NSObject, MainViewModelProtocol {
    
    
    var view: MainView?
    var viewController: MainViewController?
    private var latitude: Double = 0.0
    private var longitude: Double = 0.0
    private let service: Service = Service()
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    func requestLocationAuth(){
        self.locationManager.requestWhenInUseAuthorization()
        self.whenLocationManagerIsEnabled()
    }
    
    init(view: MainView, viewController: MainViewController){
        self.view = view
        self.viewController = viewController
    }
    
    private func whenLocationManagerIsEnabled() {
        if (CLLocationManager.locationServicesEnabled()){
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    private func getWheatherData(){
        self.service.getWheatherData(lagitude: Int(latitude), longitude: Int(longitude)) { results, error in
            if let error = error {
                print(error)
            }
            
            DispatchQueue.main.async { [self] in
                guard let temp = results?.main?.temp, let cState = results?.weather?[0].main, let cStateDesc = results?.weather?[0].weatherDescription else { return }
                self.view?.city = results?.name ?? ""
                self.view?.day = cState
                self.view?.temperature = "\(temp)°F"
                self.view?.climaState = cStateDesc
                self.view?.climaImage = "cloud"
                
            }
           
        }
    }
    
}

extension MainViewModel: CLLocationManagerDelegate {
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        DispatchQueue.main.async {
            self.getWheatherData()
        }
    }
    
}
