//
//  NetworkEndPoints.swift
//  Demo
//
//  Created by Bomidyala Swathi on 09/09/24.
//

import Foundation

enum NetworkEndPoints {
    static let weatherDetailsWithCoordinates = "\(NetworkConstants.baseUrl)/current.json?lat=%@&lon=%@&key=\(AccessKey.WeatherApiKey)"
    
    static let weatherDetailsWithAddress = "\(NetworkConstants.baseUrl)/current.json?q=%@&key=\(AccessKey.WeatherApiKey)"
    
    static let weatherDetailsWithHours = "\(NetworkConstants.baseUrl)/forecast.json?q=%@&key=\(AccessKey.WeatherApiKey)"
    
    static let weatherImageURL = "https://openweathermap.org/img/wn/%@@2x.png"
}
