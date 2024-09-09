//
//  ViewController.swift
//  Demo
//
//  Created by Bomidyala Swathi on 09/09/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    var weatherObj: WeatherResponse?
    let weatherViewModel = WeatherViewModel()

    private let hoursScrollView: HoursScrollView = {
        let scrollView = HoursScrollView()
        return scrollView
    }()

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var searchCity: UISearchBar!
    @IBOutlet weak var weatherImageView: CachingImage!
    @IBOutlet weak var stackViewDisplay: UIStackView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cityCountryNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 173/255, green: 219/255, blue: 199/255, alpha: 1.0)
        
        setupUI()
        loadInitialContent()
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        setupSearchBar()
        setupHeadingViews()
        setupHoursScrollView()
    }
    
    private func setupSearchBar() {
        searchCity.delegate = self

        //created a target for clear button
        if let searchTextField = self.searchCity.value(forKey: "searchField") as? UITextField , let clearButton = searchTextField.value(forKey: "_clearButton")as? UIButton {
            clearButton.addTarget(self, action: #selector(clearButtonAction), for: .touchUpInside)
        }
    }
    
    private func setupHeadingViews() {
        dayLabel.text = Date().getDay()
        dateLabel.text = Date().getDate()
    }
    
    private func setupHoursScrollView() {
        view.addSubview(hoursScrollView)
        
        hoursScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hoursScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            view.trailingAnchor.constraint(equalTo: hoursScrollView.trailingAnchor, constant: 15),
            hoursScrollView.heightAnchor.constraint(equalToConstant: 100),
            hoursScrollView.topAnchor.constraint(equalTo: stackViewDisplay.bottomAnchor, constant: 50)
        ])
    }
}

//MARK: -  Search bar delegate
extension ViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.showLoader(show: true)
        weatherViewModel.getSearchCityDataIncludingHours(searchText: searchBar.text ?? "") { [weak self] response, error in
            self?.validateAndRefreshUI(response: response, error: error)
        }
    }
    
    @objc func clearButtonAction(){
        weatherObj = nil
        updateUI()
    }
}

//MARK: -  Content Update Methods
extension ViewController {
    //Good to Have: Location based weather can be shown during app launch if we have location permission
    private func loadInitialContent() {
        if let historyKey = weatherViewModel.getLastSearchedLocation() {
            stackViewDisplay.isHidden = false
            hoursScrollView.isHidden = false
            messageLabel.isHidden = true

            searchCity.text = historyKey
            self.view.showLoader(show: true)
            weatherViewModel.getSearchCityDataIncludingHours(searchText: historyKey) { [weak self] response, error in
                self?.validateAndRefreshUI(response: response, error: error)
            }
        }
        else {
            stackViewDisplay.isHidden = true
            hoursScrollView.isHidden = true
            messageLabel.isHidden = false
        }
    }
    
    //Good to Have: Localisation can be implemented for strings
    private func updateUI() {
        if let weatherObject = weatherObj {
            stackViewDisplay.isHidden = false
            hoursScrollView.isHidden = false
            messageLabel.isHidden = true
            
            cityCountryNameLabel.text = "\(weatherObject.location.name), \(weatherObject.location.country)"
            humidityLabel.text = "Humidity: \(String(weatherObject.current.humidity))%"
            temperatureLabel.text = "Temperature: \(String(weatherObject.current.tempF))°"
            windLabel.text = String(format: "Wind: %.2f km/h", weatherObject.current.windKph)
            pressureLabel.text = "Pressure: \(String(weatherObject.current.pressureIn)) hPa"
            weatherDescriptionLabel.text = weatherObject.current.condition.text
            weatherImageView.loadImageWithUrl(urlString: weatherObject.current.condition.icon.getUrl())
            
            if let hours = weatherObject.forecast.forecastday.first?.hour {
                hoursScrollView.addHourViewsToScrollView(hours: hours)
            }
        }
        else {
            stackViewDisplay.isHidden = true
            hoursScrollView.isHidden = true
            messageLabel.isHidden = false
            
            if searchCity.text?.count ?? 0 > 0 {
                messageLabel.text =  "No city found"
            }
            else {
                messageLabel.text =  "Please enter the city in search box"
            }
        }
    }
    
    func validateAndRefreshUI(response: WeatherResponse?, error: String?) {
        if let errorString = error {
            self.weatherObj = nil
            DispatchQueue.main.async {
                self.messageLabel.text = errorString
                self.updateUI()
                self.view.showLoader(show: false)
            }
        }
        else if let result = response {
            self.weatherObj = result
            DispatchQueue.main.async {
                self.updateUI()
                self.view.showLoader(show: false)
            }
        }
    }
}
