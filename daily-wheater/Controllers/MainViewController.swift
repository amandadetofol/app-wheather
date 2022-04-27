import UIKit
import CoreLocation

class MainViewController: UIViewController {

    private let mainView: MainView = {
        return MainView()
    }()
    
    private lazy var mainViewModel = MainViewModel(view: mainView, viewController: self)
    
    private var loader : UIAlertController = {
        let alert = UIAlertController(title: "Fectching data", message: "Please wait!", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        mainViewModel.requestLocationAuth()
    }
    
    private func setupView(){
        self.view = mainView
    }
    
    func showLoader(){
        UIApplication.shared.keyWindow?.rootViewController?.present(loader, animated: true, completion: nil)
    }
    
    func hideLoader(){
        self.loader.dismiss(animated: true, completion: nil)
    }
}

