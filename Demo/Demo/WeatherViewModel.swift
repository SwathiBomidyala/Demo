//
//  WeatherViewModel.swift
//  Demo
//
//  Created by Bomidyala Swathi on 09/09/24.
//

import Foundation

class WeatherViewModel {
    
    private var weatherData: WeatherResponse?
    
    //Good to Have: Can move to separate utils
    func saveLastSearchedLocation(text: String) {
        UserDefaults.standard.setValue(text, forKey: UserDefaultsConstants.previouslySearchedCity)
    }
    
    func getLastSearchedLocation() -> String? {
        return UserDefaults.standard.value(forKey: UserDefaultsConstants.previouslySearchedCity) as? String
    }
    
    //Fetch data with city name input
    func getSearchCityData(searchText: String, completion: @escaping((WeatherResponse?, String?)-> Void)) {
        saveLastSearchedLocation(text: searchText)
        
        DispatchQueue.global().async {
            let url = String(format: NetworkEndPoints.weatherDetailsWithAddress, searchText)
            NetworkManager.instance.getAPIData(for: WeatherResponse.self, url: url, requestType: RequestType.GET) { response, error in
                completion(response, error)
            }
        }
    }
    
    //Fetch data with city name including hours data
    func getSearchCityDataIncludingHours(searchText: String, completion: @escaping((WeatherResponse?, String?)-> Void)) {
        saveLastSearchedLocation(text: searchText)
        
        DispatchQueue.global().async {
            let url = String(format: NetworkEndPoints.weatherDetailsWithHours, searchText)
            NetworkManager.instance.getAPIData(for: WeatherResponse.self, url: url, requestType: RequestType.GET) { response, error in
                completion(response, error)
            }
        }
    }
    
    //Fetch data with location
    func getUserLocationData(userLat: String, userLong: String, completion: @escaping((WeatherResponse?, String?)-> Void)) {
        DispatchQueue.global().async {
            let url = String(format: NetworkEndPoints.weatherDetailsWithCoordinates, userLat, userLong)
            NetworkManager.instance.getAPIData(for: WeatherResponse.self, url: url, requestType: RequestType.GET) { response, error in
                completion(response, error)
            }
        }
    }

}

