import Foundation
import UIKit

enum BackgroundColors: String {
    
    case clear = "Clear"
    case cloud = "Clouds"
    case sun = "Sun"
    
    var color: UIColor {
        switch self {
        case .clear:
            return UIColor(red: 127, green: 207, blue: 253, alpha: 1.0)
        case .sun:
            return UIColor(red: 255, green: 230, blue: 0, alpha: 1.0)
        case .cloud:
            return UIColor(red: 149, green: 163, blue: 171, alpha: 1.0)
        }
    }
    
}

class MainView: UIView {
    
    private lazy var scrollView : UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .gray
        scrollView.contentSize = CGSize(width: self.bounds.width, height: self.bounds.height )
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.isAccessibilityElement = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .gray
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 0.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        return stackView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Cupertino"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Sunday"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let climaStateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Sun"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.text = "13 C"
        label.font = .boldSystemFont(ofSize: 42)
        return label
    }()
    
    private let climaImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "sun.min.fill")
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.backgroundColor = .clear
        return image
    }()
    
    var city: String = ""{
        didSet {
            self.cityLabel.text = self.city
        }
    }
    
    var day: String = ""{
        didSet {
            self.dayLabel.text = self.day
        }
    }
    
    var climaState: String = ""{
        didSet {
            self.climaStateLabel.text = self.climaState
        }
    }
    
    var temperature: String = ""{
        didSet {
            self.temperatureLabel.text = self.temperature
        }
    }
    
    var climaImage: String = "sun.min.fill"{
        didSet {
            self.climaImageView.image = UIImage(systemName: self.climaImage)        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(){
        super.init(frame: .zero)
        self.buildView()
        self.setupConstraints()
    }
    
    private func buildView(){
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(dayLabel)
        stackView.addArrangedSubview(climaImageView)
        stackView.addArrangedSubview(climaStateLabel)
        stackView.addArrangedSubview(temperatureLabel)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: self.stackView.topAnchor, constant: 40),
            cityLabel.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
            
            dayLabel.topAnchor.constraint(equalTo: self.cityLabel.bottomAnchor, constant: 8),
            dayLabel.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            dayLabel.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
            
            climaImageView.topAnchor.constraint(equalTo: self.dayLabel.bottomAnchor, constant: 32),
            climaImageView.widthAnchor.constraint(equalToConstant: 100),
            climaImageView.heightAnchor.constraint(equalToConstant: 100),
            
            climaStateLabel.topAnchor.constraint(equalTo: self.climaImageView.bottomAnchor, constant: 8),
            climaStateLabel.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            climaStateLabel.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: self.climaStateLabel.topAnchor, constant: 40),
            temperatureLabel.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
        ])
    }
}
